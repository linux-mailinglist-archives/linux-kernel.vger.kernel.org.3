Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84A848C7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354930AbiALQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbiALQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:08:07 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E62C06173F;
        Wed, 12 Jan 2022 08:08:07 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A239C37B;
        Wed, 12 Jan 2022 16:08:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A239C37B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1642003686; bh=DPkFpdepY3Xq7hZkHRQrmZI4H683BGoTUeNeCtekHXw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LkKlvPgtuvCUGj1J9qdf6fmizE5nxd5eUS3yUtvSnc3ZcFeOc4SeU8if+4KNgJASG
         eJ/yLBUG8MEHwq1+DbrsdA9w5/xnI+o9ks/iOVubS4n++1O/CTvw7xFEEkXtMsugDt
         eZJn+m+LJXKziSn6hFzkMoOiwkFzqPCGgzf+tyyLawxgEwQ8lgVigieTo3ePgpMKhG
         j9TRXyiDppflG5Hlcc69V1awbnCZGy4KSmMZPtAx72rsTtKKd4cvhwA+bksbq/yD7P
         xGXabiNXGp2d+MC5wgYZZLAnUPen4j0OOJtJaldyPTGU+4li0AetYIl/fxFovceLff
         mbYDV+WEKhQrw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     teng sterling <sterlingteng@gmail.com>, CGEL <cgel.zte@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, xu.xin16@zte.com.cn,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH 1/4] Add zh_CN/admin-guide/mm/ksm.rst
In-Reply-To: <CAMU9jJqY5Ty-w3_tf+zxotE5CB+VdM5ZprMiZ5KbNinbDJ1F2w@mail.gmail.com>
References: <20220110122929.647573-1-xu.xin16@zte.com.cn>
 <20220110123144.647635-1-xu.xin16@zte.com.cn>
 <CAMU9jJqY5Ty-w3_tf+zxotE5CB+VdM5ZprMiZ5KbNinbDJ1F2w@mail.gmail.com>
Date:   Wed, 12 Jan 2022 09:08:19 -0700
Message-ID: <87v8ypey30.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

teng sterling <sterlingteng@gmail.com> writes:

> <cgel.zte@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8811=E6=97=A5=E5=91=A8=
=E4=BA=8C 11:07=E5=86=99=E9=81=93=EF=BC=9A
>> +.. _ksm_sysfs:
> Too many tags will cause a compilation warning, because an identical
> one already exists for the Origin document.

They are also simply pointless clutter in the text files.  Unless you
need to explicitly refer to a label somewhere, please don't add it to
the text.

Thanks,

jon
