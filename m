Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C82547A54
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiFLNXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiFLNXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:23:08 -0400
Received: from gorilla.birch.relay.mailchannels.net (gorilla.birch.relay.mailchannels.net [23.83.209.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078182EA0F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 06:23:01 -0700 (PDT)
X-Sender-Id: _forwarded-from|shared-c2bf.savviihq.com:userid:1159
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B6043121E20
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 13:23:00 +0000 (UTC)
Received: from shared-c2bf.savviihq.com (unknown [127.0.0.6])
        (Authenticated sender: savvii)
        by relay.mailchannels.net (Postfix) with ESMTPA id 98AF6121E17
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 13:22:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655040179; a=rsa-sha256;
        cv=none;
        b=6lRdSXfXSzAnXcJVdeVdGPs8plgjjkRo4C2iXVyADSMciWC82w1189fL0mtZcE0AN66M9S
        zqi1jTB3eliYDYoBsXgGr81okaT6dWuUvgG5wNt+YqaEPFQuEeqcEqNt8zjuvQDwxEq59D
        DPD7A7ZkHUcufqPJIeBjM2Iu9HmVzfAV4vPvKEddhXl1oVi4Fkjtqzv4YtCl4wDfDHjL/p
        hUhvH/qCqueXTNTIMrb+iAPOojWJXylyTQpixLkowJf9W9gUX2uc9CbVqx4U1znm1P6b46
        LcGfD4FRwT32feNrfz5swkTkYZsfcGVkoYdZoI1yp5BATYKvbbK1lumb/7+dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655040179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jb64pKnRSqaSwKvbQPorjAIF0d+EL5vPIH0RZH7OUow=;
        b=VN+tlc5nZZncU38JKwEVVbRKbBhBO03zhhoAelTp4L6ytt36oKzU7D1KLKw27x63ztylWK
        mwy/0NJa6wZseTX2NT2+UfXnyQNosFRp+O0yGZ2k9z1TVSPHUQVyx7ouO6VBlWo7aVEREw
        dYM2NcUdEdC3+dTDParQ4UrlUmVDzwQY2AO+N/yqBZakTLIyPqifIKLhyhQA1SLoXT9529
        gWsuSvQWN6e8bFWcW64cQjUuPIPg9G8tBpNjnafWcqKElldsQiUUwyAp607o29u0pJjJEr
        ITnYiPop4xpL4WjGLMzCaGozN4PrW1+SsKbQAZCKVGrkEcSe2KsGigKbv+HSVA==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-shrnt;
        auth=pass smtp.auth=savvii smtp.mailfrom=nuhetm-bilobugis@sites.savviihq.com
X-Sender-Id: _forwarded-from|shared-c2bf.savviihq.com:userid:1159
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|shared-c2bf.savviihq.com:userid:1159
X-MailChannels-Auth-Id: savvii
X-Illegal-Abaft: 170825f40d4688eb_1655040180146_2020061409
X-MC-Loop-Signature: 1655040180146:619360128
X-MC-Ingress-Time: 1655040180146
Received: from shared-c2bf.savviihq.com (shared-c2bf.savviihq.com
 [139.162.182.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.120.38.187 (trex/6.7.1);
        Sun, 12 Jun 2022 13:23:00 +0000
Received: by shared-c2bf.savviihq.com (Postfix, from userid 1159)
        id 32AAA10335; Tue,  7 Jun 2022 12:53:42 +0200 (CEST)
To:     linux-kernel@vger.kernel.org
Subject: Het Moment Ritueelbegeleiding
Date:   Tue, 7 Jun 2022 10:53:42 +0000
From:   Het Moment Ritueelbegeleiding <info@hetmoment.nu>
Message-ID: <HuZJIB1wtJilJEiaE4D7zni1ZZeH0X6oNkA3VXuAjw@hetmoment.nu>
X-Mailer: PHPMailer 6.5.3 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DATE_IN_PAST_96_XX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [23.83.209.75 listed in wl.mailspike.net]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [23.83.209.75 listed in list.dnswl.org]
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

Beste 💌 Anita want to meet you! Click Here: https://dreamgirl22.page.link/H3Ed?zji 💌 ar2tru,

Bedankt voor je interesse in de opleiding Ritueel begeleiden.

Je aanmelding is in goede orde ontvangen. Wij zullen deze in behandeling nemen en vervolgens via mail contact met je opnemen. 

Wanneer je nog vragen hebt, twijfel dan niet om contact met ons op te nemen. 

T: (0345) 58 23 40
E: info@hetmoment.nu

Hartelijke groet,

Team Docendo & Het Moment

