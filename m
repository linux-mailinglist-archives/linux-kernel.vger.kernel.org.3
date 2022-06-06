Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E5553F1E1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiFFV43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiFFV41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:56:27 -0400
X-Greylist: delayed 507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 14:56:24 PDT
Received: from vps87552.serveur-vps.net (vps87552.serveur-vps.net [31.207.38.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AA25F252;
        Mon,  6 Jun 2022 14:56:24 -0700 (PDT)
Received: from vps87552.serveur-vps.net (localhost [127.0.0.1])
        (Authenticated sender: offre-valable_pourtous@adiegroup24.com)
        by vps87552.serveur-vps.net (Postfix) with ESMTPA id 833437081FD;
        Mon,  6 Jun 2022 23:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adiegroup24.com;
        s=default; t=1654552073; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hI96B4AvQ94OtQD5c66/SHmG3wRTtyUZYZfeujzxVPM=;
        b=XLCzvx9AHRL5xq7R0GvIT7nMBso+E/jQfmmObmPrMJMSVUmHvY2Ijc+/2ZsTxaF6rszykZ
        0HskBjNPc0Rvgk3C6bvi2YfXzNY7U28+UXVKTCOm54g/G52exA3LwxI2BY77U6QY4U0M3g
        z8DeJ61uSRmALOA50Q9u1rhYwZg9dJhpQ5D0qafNLEWFtSrRpzOx0HD3b4FQW7+cvdUhZt
        4L7qywHUNZsdLsehBuQRpvsjiANPJmpscPw9zJcoKjwQX9CNA2h0nUH7ur5wgD891VkOBJ
        o2AzMXFC/w6acsYcGMml0oQosywZOdWHudJBrB/6KJ5mx70DEkt1JcMtrxz6JA==
MIME-Version: 1.0
Date:   Mon, 06 Jun 2022 23:47:52 +0200
From:   =?UTF-8?Q?Gelegenheit_f=C3=BCr_alle?= 
        <offre-valable_pourtous@adiegroup24.com>
To:     undisclosed-recipients:;
Subject: =?UTF-8?Q?Gelegenheit_f=C3=BCr_alle?=
Reply-To: noellepaul000@gmail.com
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <867f7a60a74cdb09cf1f35b2cb1a4bdc@adiegroup24.com>
X-Sender: offre-valable_pourtous@adiegroup24.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [noellepaul000[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-- 
Wir sind ein Geldverleihdienst zwischen Privatpersonen, der jedem hilft,
der einen Kredit benötigt. Wir können Ihnen einen Kredit zwischen 1000
€ und 25.000.000 € mit einem festen Zinssatz von 1,5 % gewähren.
Erhalten Sie einen Kredit, um Ihre Schulden zu begleichen, Ihre Projekte
durchzuführen, Ihr Traumhaus oder Auto zu kaufen. Wir bieten das 
Darlehen
jedem an, der zu unseren Bedingungen zurückzahlen kann. Sie müssen einen
Kredit aufnehmen: Finanzierung * Wohnungsbaudarlehen * 
Investitionsdarlehen
* Autokredit * Konsolidierungsschuld * Kreditlinie * Hypothekendarlehen 
*
Kreditablösung * Privatdarlehen. Sie sind aktenkundig, haben Bankverbot
und werden von Banken nicht bevorzugt oder noch besser, Sie haben ein
Projekt und brauchen eine Finanzierung, eine schlechte Kreditakte oder
brauchen Geld, um Rechnungen zu bezahlen E-Mail:: 
noellepaul000@gmail.com
