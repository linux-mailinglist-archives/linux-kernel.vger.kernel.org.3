Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8DE55FC48
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiF2Jnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiF2Jn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:43:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568822C649;
        Wed, 29 Jun 2022 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656495805;
        bh=mJOwwfLfmhztjVcr0+q6cxXiaBNeoFLnht348Tfw2YQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=YrHEdP4KrTxBcy5x5IBRxRM4Oxy4AbSzJnhNi0wu+FzyCeYqqSLx2/gonaqRH29jJ
         qnmWdf4/qIBeBox5gQGuu6CHvcEdaSzrCI3FSmUA2ucT4kzC3ndcmyaedDbfYSzcrd
         ndEPNkR4oKQ9RFKQyOUCHHxfUWmPab9ILm9BXcFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ic-alex-elitebook ([155.198.137.233]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowKi-1nHTk316B4-00qTUh; Wed, 29
 Jun 2022 11:43:25 +0200
Date:   Wed, 29 Jun 2022 10:43:14 +0100
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: input/i8042: Malfunctioning brightness keys on HP Elite Dragonfly G2
Message-ID: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:SpeUT5f+FlwiMIdlPUamfLdm7kiwBe2RVBdT24r0CXtOyuF71rC
 pEJsLiXrCHD6WA5N4Tk5FtzdfWm0OOVE/57NImlvVwFaGgFC+ejUOYV2/z0+h8R0xJC1JhP
 zpc/VniJIwSVj18VlGMqy4ILFRYiZ7hMfF1GO1ni1S4mPEl5AsNEljnptnXn3Y/ff6PMyT5
 JJJAUI2vGo0XRyf+QRUNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9uNM2iCq4JE=:oimxqr8c0ToU6Gu1Y7QhNX
 z/Y5pnlNDA/+M9eON+q5iudjn8nBFZp8E7Wyuu7OleDTDpR9lLI+t5Ye+K0fJVGj1p6g3ZXD/
 ZQe+T31AZfOmrO7tqHRbH43sUa6Lk6R4Su266/21WOa8j/U426BXYqYZQm2OpFTwCQdVo6HdC
 olznECZ9NO9YhfsgEqfr2GUAXSbi2oWWZ8Hd10WWjDGZFNHYwrMr3x2Hsgw2bRnJ0o2BHE2Nh
 5URtaa7CyhG0BuPYgWUaT8rNjhUhKAojv2qOvUwHVeRtMpeEqb2u7E/ff4FJzuLHcmKLCsoHX
 2Sz5SWK02iYezQL4VTYYdB7D3bozDz1g8BUQ6gMQaQynLaqTM3TKFVWsZ4/9lZjOBpelvezmV
 8QzrMjli91E/941pb3ud4NCIKZ8OrQH+lWXlHr9f4TjHLWQkMZ5gOdCL1deUITL1QB3L8ncE0
 FkFh7LPiDa8rNL+6GThd2rtiRk9TUnlie3OiWOkvARsTyW3GTCJ7Z+aG8+NQZAFu8B11jpxTB
 ud2VqZ4p0FYSrlkFdrJcLabiwuFJtlSMRn0qR0cUuHZdTEz7YHpF0ZYXE92LLYWRP6wBPxuNt
 VHvem0aUuUbRTS2pYeZlhp9FM47QbEUwFBgmK7uebI/tpL4YAaVye676VtOWadVIF1h1GrGXi
 +SK37+uz/hHBQQNKfos4d+OzZixbtFkkE/KioTIlAxSwFpwEWEMJ6KLF6k7wKTaN3bnC8H/sI
 YDMKmVKxbzhwgOVzTKdoggeAj23O9bgDrZc9ZaAGqUHe3NO4WNStDgBgKWKzx7Fi9iTReZXcX
 zZExy1PSrG/uOt84Z/9Lt72x1iBUhRSGwFMji0A3LQe28xwrLhkZvPaEy/hW39W7tNdeDidlW
 DjVFPNi8pOHdT0HNR5Bm3FSawLZHAoZrkkMlY7mLEMJvsv3F/osrPESTsQBm/FCVP7aEr2sBN
 fwRmWhWNzvU1hn6ZNzXa7iQ+1mz2SkILX+MbdFfhAu/FU2UlUzHs17Hn3g/h1dvTnvAeHl6P9
 1RBc+w7sWQyoNISDYMp9FKNAs+eoUxF6Si1ZnLUzp3cy1iQSt23H1pPvKBYxDiqGf/iJI77vH
 GSSnsrMdL+K6KDv3ZXII2+Mn+IGjECg/SuquwUkRI/lOUwdmTCTT7VXJA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running Linux 5.18.7 on an HP Elite Dragonfly G2 laptop, which seems
to use the i8042 driver. Mostly things seem to work (including hotkeys)
except that the increase/decrease brightness keys instead send the "mic
mute" keycode. (The *actual* mic mute key works fine.)

Any ideas? Do we need to add a quirk?

Best,
Alex
