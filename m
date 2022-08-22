Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3646359BC16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiHVI4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiHVI4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:56:18 -0400
Received: from burlywood.elm.relay.mailchannels.net (burlywood.elm.relay.mailchannels.net [23.83.212.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BABB2AE07
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:56:15 -0700 (PDT)
X-Sender-Id: spamcontrol26|x-authuser|administracion@corporacionabgsac.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7A599761B85;
        Mon, 22 Aug 2022 08:56:14 +0000 (UTC)
Received: from priva170.spindns.com (unknown [127.0.0.6])
        (Authenticated sender: spamcontrol26)
        by relay.mailchannels.net (Postfix) with ESMTPA id D3509761643;
        Mon, 22 Aug 2022 08:56:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661158573; a=rsa-sha256;
        cv=none;
        b=P53J48fGltNu+nqueaIkEjc5QxoU2mceQIxw4lFhdsJ1ICu2Y02c34Bxfvk18e+zVUrxp/
        /t4VTxD3MeiLtAaKRrP3f/fXGFalit+h4Cmxha4RrrVEDuPOe6relKfmnyhzlEK1bx9Vd1
        b0WYek81F69mI+y2rXtb+G5HlCjXLd5DS5Uq5VElOs3GHRWtx4qKzBQfiqAo/wz1O0ZdmY
        zqJYz18eKdGX1yNOpgNOPtNOuNVaUpb92rl4wSlbzO7WyFfZwnsWMN/iu+Q7bvaHGPpy9y
        JB+fki1S75RkfvQyeItCDLhqJ8ymNPxeP6fWe4ZeShS+JXzG3kXfrz47noNrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661158573;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=wJxBS8GljCGjZnih+ZbPmMZBqXOVtTCPRbpHKRKCnmo=;
        b=dHNn1ocf46wAsIteqZJavgdzcF9f25Mq4p8yPdhNYBBmgS+McCTVlYQxC6wLm6ZW8PLwSb
        iSNKOOwNigL+3VXMe1CqefmW5S5Axulwv9pviNZlGabiMWyLXPg/xqMtDpHPvO2ATbuTpA
        Z4nFP+1nGTuNE2kGkbyZFQPzuHkxn0OmhNXC/ri0syCB35aVGSbmj3aKW58dTY587oTpJu
        aN/roL+yR/O3gNnIIUesOp2lFyR+NKYCu1j4RHRec9rNKGmp9AF1jEn0jJq5rFaOHQ9gbW
        viGDNpiM5Mwltt8yHQ+JebiJCZm4N2caYaHjrMbhi2MIoYSOd3jUbrGwSrLOaw==
ARC-Authentication-Results: i=1;
        rspamd-769cfffc99-gz2kr;
        auth=pass smtp.auth=spamcontrol26
 smtp.mailfrom=administracion@corporacionabgsac.com
X-Sender-Id: spamcontrol26|x-authuser|administracion@corporacionabgsac.com
X-MC-Relay: Junk
X-MailChannels-SenderId: spamcontrol26|x-authuser|administracion@corporacionabgsac.com
X-MailChannels-Auth-Id: spamcontrol26
X-Inform-Industry: 0e04940350cad0bb_1661158573948_497585332
X-MC-Loop-Signature: 1661158573948:1428180309
X-MC-Ingress-Time: 1661158573948
Received: from priva170.spindns.com (priva170.spindns.com [75.102.22.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.116.106.110 (trex/6.7.1);
        Mon, 22 Aug 2022 08:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=corporacionabgsac.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        Message-ID:Reply-To:Subject:To:From:Date:MIME-Version:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wJxBS8GljCGjZnih+ZbPmMZBqXOVtTCPRbpHKRKCnmo=; b=Kk4+klS5WhNJBJs9rW68BMbkbq
        BctFq4bZ5Vj6ACEkc8heVHctTb1nWWS70Oz/JG4k9gwEljHzgKSZaXau3wCTlZO7+IFJi4yFGmx5A
        7ZC1KQop2kq3VUUuOIHonOt6qTJBu8H5VYtDlfbMrI3IXZr+ZxwmXhVzvPKyMpSKEvHf7hJt7PbZz
        P9+5otnFidGcDRPJPvotLZiRpoTl1oO30fRM+bE9enP6eEY4KvocZmlGFkruAvj4iyGCqVAHJmK/F
        jxKvmXpstu6sOSNu6HU8Co2dek+uozaFBjmgSDgNMqR/35j8ayH1mXDwZBBFO2ypANCBPTPkS3l13
        Ln0ZuIkw==;
Received: from [::1] (port=45266 helo=priva170.spindns.com)
        by priva170.spindns.com with esmtpa (Exim 4.95)
        (envelope-from <administracion@corporacionabgsac.com>)
        id 1oQ3E5-000Ghr-4h;
        Mon, 22 Aug 2022 04:56:07 -0400
MIME-Version: 1.0
Date:   Mon, 22 Aug 2022 03:56:04 -0500
From:   Michael Kinciad <administracion@corporacionabgsac.com>
To:     undisclosed-recipients:;
Subject: Positive OUTREACH
Reply-To: michaelkinciad@outlook.com
Mail-Reply-To: michaelkinciad@outlook.com
User-Agent: Roundcube Webmail/1.5.2
Message-ID: <603f9e02fe543e730a1397babc7ec753@corporacionabgsac.com>
X-Sender: administracion@corporacionabgsac.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-YourOrg-MailScanner-Information: Please contact the ISP for more information
X-YourOrg-MailScanner-ID: 1oQ3E5-000Ghr-4h
X-YourOrg-MailScanner: Found to be clean
X-YourOrg-MailScanner-SpamCheck: 
X-YourOrg-MailScanner-From: administracion@corporacionabgsac.com
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        ODD_FREEM_REPTO,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-AuthUser: administracion@corporacionabgsac.com
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?23.83.212.26>]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [23.83.212.26 listed in wl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 ODD_FREEM_REPTO Has unusual reply-to header
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Prospective,

Leus Pham Netherlnads B.V  (NL), is one of the leading 
bio-pharmaceutical medical drugs manufacturing companies in Europe & 
Middle East.



We are looking for a well-grounded entrepreneur /business individual in 
your Country to represent this company in sourcing for most of our basic 
raw materials used in  manufacturing of rare medications used in the 
production of most vaccines, cancer treatment and other life-saving 
pharmaceuticals including Madagascar's prescription for VOC treatment.



This may not be your area of business/profession, but it will surely be 
another revenue-generating pathway outside your professional network if 
you find this interesting. This is because our company is yet to find a 
supplier to purchase from after we lost our previous supplier.



More Details on Profit and Processing Available on Request.



Warmest Regards,

Michael Kinciad.

Senior Research Specialist

www.leuspharm.nl
