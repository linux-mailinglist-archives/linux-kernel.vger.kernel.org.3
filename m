Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254B953CAA6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244627AbiFCN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244339AbiFCN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:26:35 -0400
X-Greylist: delayed 1419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Jun 2022 06:26:34 PDT
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.144.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482CE36B6D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:26:34 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id C060AD6803
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:02:54 -0500 (CDT)
Received: from sh019.hostgator.in ([162.241.123.134])
        by cmsmtp with SMTP
        id x6x4nmBEx7B0Ox6x4n1y2X; Fri, 03 Jun 2022 08:02:54 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eventb2b-datalists.com; s=default; h=Content-Transfer-Encoding:Content-Type
        :Message-ID:References:In-Reply-To:Subject:To:From:Date:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kSRBoP6yNtfG6H610KOXt1Fc5+z2McpqAm0h3Wg+rQw=; b=jpYYtU2u3hhgXwIZB1AbcbkKq4
        31ADZydn0u2IFODB0D6RKbKt+hgqbolqDzpKrm4kwEbZU2LxfxLbmh7Qecnd2pLTWyXPdb0bluqaZ
        zCDvZoUiPKFyP42QEKHfXG3FyUYYDaX+QXfIPMqLSNrtBECm3gRYj7cH1yMPa5+K0a26RMj5vH7ZR
        6fn/FTUZzsZFk7FRGN5bBqVsA3wXSzbiCM3JBi73seFpDo0h74QclmdNyUKDPg2NK9aQlC+DeiD6z
        lMb3iK69pWSiFCOSIrlyKdM7qe3aOoITebSH4/0xLOwdwVX4ge+4V3niQmm4ofc676zn60MP3p3js
        inTVU9Gg==;
Received: from sh019.hostgator.in ([162.241.123.134]:11706)
        by sh019.hostgator.in with esmtpa (Exim 4.94.2)
        (envelope-from <harry@eventb2b-datalists.com>)
        id 1nx6x3-000gKs-4v; Fri, 03 Jun 2022 13:02:53 +0000
Received: from [49.37.186.160]
 via [49.37.186.160]
 by webmail.eventb2b-datalists.com
 with HTTP (HTTP/1.1 POST); Fri, 03 Jun 2022 13:02:52 +0000
MIME-Version: 1.0
Date:   Fri, 03 Jun 2022 18:32:52 +0530
From:   harry@eventb2b-datalists.com
To:     jxchen@s2cinc.com
Subject: Re: 59th DAC - Design Automation Conference
In-Reply-To: <e6fe26e58652d8fa746b6cb320d2dec3@eventb2b-datalists.com>
References: <e6fe26e58652d8fa746b6cb320d2dec3@eventb2b-datalists.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <2fdc9f6dda8e4948da67f412e5991e14@eventb2b-datalists.com>
X-Sender: harry@eventb2b-datalists.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sh019.hostgator.in
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - eventb2b-datalists.com
X-BWhitelist: no
X-Source-IP: 162.241.123.134
X-Source-L: No
X-Exim-ID: 1nx6x3-000gKs-4v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: sh019.hostgator.in [162.241.123.134]:11706
X-Source-Auth: harry@eventb2b-datalists.com
X-Email-Count: 4
X-Source-Cap: ZXhwb2J0aG87ZXhwb2J0aG87c2gwMTkuaG9zdGdhdG9yLmlu
X-Local-Domain: yes
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-27 19:34, harry@eventb2b-datalists.com wrote:
> Dear Exhibitor
> 
> Are you joining the 59th DAC - Design Automation Conference and
> networking with other exhibitors?
> 
> Are you planning to get one-on-one time with experts and boost your 
> skills?
> 
> Equally essential for the benefit of your exhibit is the quality of
> your attendees!
> 
> Let us know if you are interested and we will send you the attendee
> list for the exhibition with full databases including email addresses
> on a spreadsheet.
> 
> We provide accurate data and quality databases with relevant attendee
> titles and data fields such as: First Name, Last Name, Website, Email
> address, Title, Tel Number and many more.
> 
> Amount have been lowered, awaiting for your approval!
> Looking forward to hearing from you😊
> 
> Regards,
> Harry
