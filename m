Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9E47C0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhLUNbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:31:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:43549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238201AbhLUNbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640093478;
        bh=NE7B2Uj27oq01oB999F9nL30To46EDpOXkHPpstsVU8=;
        h=X-UI-Sender-Class:Date:From:Subject:To;
        b=ToAtXkjPzOWMQPC7n4UhogGjxjyQZS8EPhHmwkcEuNZDvlp/LdjvWjUPcvQapzLBR
         226l+Ry9OtbLtjUc58iOgistj6epd01/SVlaWN2InCdkMfgL6RKgilu2rhfy33SWyC
         kD6yUPXZiZO5W3CVOY2ea6CCbnSoV7ADk3JHd4qY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.252] ([5.166.175.171]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1mA1sw3IN5-00stgJ for
 <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 14:31:17 +0100
Message-ID: <2dca3f30-3f22-6b40-ee8c-6d02b7613132@gmx.com>
Date:   Tue, 21 Dec 2021 13:31:16 +0000
MIME-Version: 1.0
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: User being unable to decrease process nice value
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HwjHQSfJwTpdvxMhhXlpesKvVKNvo+8DcLiGqG1ESytY3lOtwwZ
 9hr+DPXo+EsVKNAa8c0WOObrHuGNgkpxxH/B4oNtojmzMoIOhErOmuJwvwcF5uYcWyHCuqr
 LDUM10plhlWanbYisLTKeKU2TZmsXRflhoMLjPBfEwAtiLhN3TOj31LmPLc6GB3LhL/MAFG
 gvay8oDU33gXyYkfdLPlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1ycchAjX6zg=:foOZ3/MGMWic+IJz4ik09L
 sFI+VAGmd6pV4gv0+VxywprMRJmn3ZJDUw7t+Jsz26moO2b8ouASEpaMPERcANrmEiGcxY5ZC
 T8uijT7R0gQmrUGx0+U0rEaKmN+EWOXUCN3Vj0R4g38mcUX4HMjolJ/S+/Z3heSP3bLEKgzYA
 iKxnVVqSGemd0weGxjq25cPK/hXX8ria9EI96faFy9NLLnfMLIi2Q+RRIINU0zhig8G8X9/TS
 VLcfBQfc166QXvW1W9SxZ42/4fn6aiCz0eihshhf3c6usunGbdzeGVSBgDa7dH193yRUotob1
 GfKDb2//oPWiECwaWGVfz+0JmvwIy/Y6qXxfmyHYWG+ZVobVOiUBWocGo+45hqJ3+NgHtHb+7
 1BTbQnszvoLavAPob75qVLo70cCsP2B6xFMv8YKbPtPV4s1SoRI2HidhgSaPUfG8m2m8d7xp/
 k9nbvBw9vrj9i6M1CPHa07mhYN/LAz7xzUQIBYtB1vj4z7f4jxjho3oeIZpmurobiBOWwaIbx
 U45kExE9E6xLHNT4TreoQqJ6ADtDs2EFMcos9rVBWfdDJPPl4fKpP2/ychNJSEOF1/G+60+nH
 7K1dk/3v69OqqhKncQq42VrhtqheOSZsAAzrE0ENE7qaCWntSKvwi2Pjnmo/T5liH2bH6WDCx
 PZlqf1r18PKJ0v0zIU5nYedJNEFcbXoyBp2aS5IZS3BNJMm3PaGpzq37g1CA0qesor3PXprrU
 SNtM4bQdYmXAxk2QZrjqeOji6Zl7xQsyhCRA7W7HQVOW34Kcz6qQVB8UdalLqxdGvrb0MTcCO
 tvXbcdB2VwA9eUDJvuVIK6Z1bByBVQjUmMoYqwXM4WvT0z8QUIdxmnmdI/F2zrjCXABZXBno8
 lwNT8LPzXf7BLN42E9luCPkfXxj6pHx27fW9hVfjygkLNTsiuqCo5nCr3IWCcDTs5y5VpK2Fo
 ToepyhILTqXCRfmDY3O+RZ2Cbgqn5e9N5AkmniPuva5c2nTnKUf3NijvsfSnnEMMCAiDKaT6U
 lijnn06ahC44+ZlmfqbBNap3hUm20QsY1v61QD2ydlFZoHFVaX7JFsU32Hx5IJc59Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been unable to find any rational logical complete answer to the
following question.

In Linux non-privileged users are able to increase their own processes
nice value but they are not allowed to decrease it back to 0.

To me this does not make any sense because, even if that's some kind of
very old policy/rule from old UNIXes, the user can still simply restart
their processes to get to the coveted 0.

What's the rationale behind this seemingly illogical and easily
circumventable limitation/restriction?

Best regards,
Artem
