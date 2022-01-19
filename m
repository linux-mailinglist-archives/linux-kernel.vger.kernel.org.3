Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B2A493DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355948AbiASPvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbiASPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:51:54 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED192C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:51:53 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 65A23223EA;
        Wed, 19 Jan 2022 16:51:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642607512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tE1VF3g/rX5C3ifjMZBPjLLm6cBP9Tc4XyzTVG+pf1I=;
        b=SaNAtkBMsm4GrJgTbHVgzd1P+k0oh5U18nnZaPDkG0YBL4cZXkg83Yj0OI34sZiWw39Suv
        7fwiJeDvG84R9pNQAlN/WysgPtI0tgvKFG674e8MYMiRGOR4V1yk0s7P0hXEZIx1f/ws0x
        1QLIcsEiaGiL8Q8LcwGw4vRlfGOPAOk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Jan 2022 16:51:51 +0100
From:   Michael Walle <michael@walle.cc>
To:     "Sajida Bhanu (Temp)" <c_sbhanu@qti.qualcomm.com>
Cc:     Tudor.Ambarus@microchip.com,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        dianders@chromium.org, p.yadav@ti.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org,
        vbadigan@codeaurora.org,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        sartgarg@codeaurora.org
Subject: Re: [PATCH V3] mtd: spi-nor: winbond: Add support for winbond chip
In-Reply-To: <PH0PR02MB84557EA76BD8DDD35A99B915CD599@PH0PR02MB8455.namprd02.prod.outlook.com>
References: <1639476991-25676-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <488aafc3-2fa9-198b-c448-d1ca7ef52f35@microchip.com>
 <PH0PR02MB84557EA76BD8DDD35A99B915CD599@PH0PR02MB8455.namprd02.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <b4aad212d86b2d4dd27602db6add82e3@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-01-19 06:34, schrieb Sajida Bhanu (Temp):
> Gentle Reminder.

As Tudor mentioned, you'd need to rebase your patch to the
latest next.

Thanks,
-michael
