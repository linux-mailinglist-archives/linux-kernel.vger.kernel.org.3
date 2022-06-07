Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D955478B1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 06:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiFLE0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 00:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFLE02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 00:26:28 -0400
Received: from gorilla.birch.relay.mailchannels.net (gorilla.birch.relay.mailchannels.net [23.83.209.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEC854034
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 21:26:24 -0700 (PDT)
X-Sender-Id: _forwarded-from|shared-c2bf.savviihq.com:userid:1159
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3E9F1121449
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 04:26:24 +0000 (UTC)
Received: from shared-c2bf.savviihq.com (unknown [127.0.0.6])
        (Authenticated sender: savvii)
        by relay.mailchannels.net (Postfix) with ESMTPA id 81FA6121693
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 04:26:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655007983; a=rsa-sha256;
        cv=none;
        b=JWmzUPbIhf1n7/8njIZPAxShMd7XnFsBnwoiDQwaXuDJyGYrwMiUEvey50BJoG1VlDGTZ3
        0c9BBgLrWA6OPjIITz7fqqGro30ivKuSDXgmvzTb3O/BYj090G27zJkWf1zCed9MHYQwv9
        Q/P0IZigH8L/xhBTkAbRaewQb60rp1W2qF3AS7RScrMDi+kjdqGzi7hjEgWa1FKtfy0y8/
        HWdrXrv23ShyDLs6DjT/u30rrXzRnG9TwFDnJssvfXqZRQi262fSANmLFN3hvR065iuskh
        cYCR/2yDNbLVt+770e7lpVQxXanu23kortUZc6KgPs/X3Pjf8CIH98OdQ+68qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655007983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QPos/7yMb1/fQ9AYNdnk1XGN6T1qO/XcNXlL/YLuej8=;
        b=YeeeO7kjPpblxjQK+X5DGs32q7pGjaf0fJ34/Hbh2AeumUfW4popUbD5ePXKwx27vWaqkY
        Tq0XmyksSq0Uo+c2O77p73IOMO4QfUHaQEX5UkrIx5YRhDLuocwqYoC2BsjftzHYFid1AG
        Ac8DyeasK9cx1+RIDvIjfq11JDPRNvHm+NImBdSWUW77dHQPNR0SeH3LjIkOy3yOwuE5E9
        +7bHeOM4HbDxlvFpm3azTvj7GuXVF4CP+CMwRF+xkKerWcDFEkfpjqP/4FQDrXgdSAo4E4
        gK9zTjinDbvdHzKArbjkQUEoQ4G8oFIj3sYAwD6K8tRcNnjOnTrMHJXlQDhe0w==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-gfnlr;
        auth=pass smtp.auth=savvii smtp.mailfrom=nuhetm-bilobugis@sites.savviihq.com
X-Sender-Id: _forwarded-from|shared-c2bf.savviihq.com:userid:1159
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|shared-c2bf.savviihq.com:userid:1159
X-MailChannels-Auth-Id: savvii
X-Soft-Wide-Eyed: 1229735e0dd51d87_1655007984149_3058797224
X-MC-Loop-Signature: 1655007984149:2922948240
X-MC-Ingress-Time: 1655007984149
Received: from shared-c2bf.savviihq.com (shared-c2bf.savviihq.com
 [139.162.182.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.96.51 (trex/6.7.1);
        Sun, 12 Jun 2022 04:26:24 +0000
Received: by shared-c2bf.savviihq.com (Postfix, from userid 1159)
        id E451BAAD6; Tue,  7 Jun 2022 12:53:34 +0200 (CEST)
To:     linux-kernel@vger.kernel.org
Subject: Het Moment Ritueelbegeleiding
Date:   Tue, 7 Jun 2022 10:53:34 +0000
From:   Het Moment Ritueelbegeleiding <info@hetmoment.nu>
Message-ID: <Sx4sPVklxeIvRAjE5VGafgfrnYBIz9Q3Jzghrl0z8@hetmoment.nu>
X-Mailer: PHPMailer 6.5.3 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DATE_IN_PAST_96_XX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [23.83.209.75 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [23.83.209.75 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  3.4 DATE_IN_PAST_96_XX Date: is 96 hours or more before Received:
        *      date
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.0 SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beste 💘 Have you ever tried this sex game before? GIVE IT A TRY: https://dreamgirl22.page.link/H3Ed?b1wg 💘 j28tg6,

Bedankt voor je interesse in de opleiding Ritueel begeleiden.

Je aanmelding is in goede orde ontvangen. Wij zullen deze in behandeling nemen en vervolgens via mail contact met je opnemen. 

Wanneer je nog vragen hebt, twijfel dan niet om contact met ons op te nemen. 

T: (0345) 58 23 40
E: info@hetmoment.nu

Hartelijke groet,

Team Docendo & Het Moment

