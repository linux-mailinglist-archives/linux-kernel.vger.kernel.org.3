Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF94F5AA37E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiIAXFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiIAXFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:05:14 -0400
Received: from bat.birch.relay.mailchannels.net (bat.birch.relay.mailchannels.net [23.83.209.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80063140D6;
        Thu,  1 Sep 2022 16:05:12 -0700 (PDT)
X-Sender-Id: techassets|x-authuser|susanlee41@ingodihop.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 55D7B6C1D54;
        Thu,  1 Sep 2022 23:05:11 +0000 (UTC)
Received: from vmcp128.myhostcenter.com (unknown [127.0.0.6])
        (Authenticated sender: techassets)
        by relay.mailchannels.net (Postfix) with ESMTPA id 10CD66C1F2D;
        Thu,  1 Sep 2022 23:05:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662073510; a=rsa-sha256;
        cv=none;
        b=7MJS/51PfgLWhnOwk5oARovdJozlTqizzAFqzyFZGWo8RbKR+ummzE1Co25AJciEGWQ2IQ
        FMT37PVVoUEJHXpFDCBBT9234M6rT2egBPrd7HvoxU+v8kTIMW2dVESjC2foEPvIhqLZOq
        blINJ9DuqdCGy2B8bLhw5rlZUuDVnnmLei3NfOKv8VCGL+pH8XMQhx/SshRvMLoAocUI3f
        va8Xtf3ovzPRMa/Mu0+5x83lPSECiRFqVnmyXijOd70MKwt5CvhqRUMQYZFOyHoKcyBuoj
        AxQFYXZ2Tp/tQQK0GaeRAMN1CZ4zFV1yZyJbOJtbMR2FFRePA7ELgt1VcQYfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662073510;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lk3bJyd8y857dJgjG4s8NjFXdOCsb6gQAFjio/VR4EE=;
        b=x5hKVe8WpHAMseEQUt0Qree2tv94I1zqIsoh+B1IfqyPiSfEijkBesuHO/HfjyaXeY/A8e
        zHU1riOneNyPYWS9DFg4rIER7o4PndopwWl5Cxha8UEYyJcOxvz9jhDlB3X7N4MrzK2NnP
        L29OtNpkuva1GcIXNos1RurAs0vMigZs2EK/tOAKS20QwL+k7BB3Lz7cpdM5XpdYiz5M/A
        bcS6axRhpERHwlJgWPGyJqQ8YbdBok3yFYQXiAe8bkWyw4VPSN3zURMf36WgQXGGnNva4A
        vODh9pAAZzDr3m9r52ABS9vgKsvCqLgPyFh9pLgrI9WC/ScV9klf9DK+8GhWGA==
ARC-Authentication-Results: i=1;
        rspamd-64cc6f7466-z75tt;
        auth=pass smtp.auth=techassets smtp.mailfrom=susanlee41@ingodihop.com
X-Sender-Id: techassets|x-authuser|susanlee41@ingodihop.com
X-MC-Relay: Junk
X-MailChannels-SenderId: techassets|x-authuser|susanlee41@ingodihop.com
X-MailChannels-Auth-Id: techassets
X-Lyrical-Company: 5a0605701f3ec295_1662073510925_3072724343
X-MC-Loop-Signature: 1662073510925:349382240
X-MC-Ingress-Time: 1662073510925
Received: from vmcp128.myhostcenter.com (vmcp128.myhostcenter.com
 [66.84.29.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.240.197 (trex/6.7.1);
        Thu, 01 Sep 2022 23:05:10 +0000
Received: from [::1] (port=32800 helo=vmcp128.myhostcenter.com)
        by vmcp128.myhostcenter.com with esmtpa (Exim 4.95)
        (envelope-from <susanlee41@ingodihop.com>)
        id 1oTtEr-00F0f6-IA;
        Thu, 01 Sep 2022 19:04:43 -0400
MIME-Version: 1.0
Date:   Thu, 01 Sep 2022 19:04:19 -0400
From:   "Mrs. Susan Lee Yu-Chen " <susanlee41@ingodihop.com>
To:     undisclosed-recipients:;
Subject: INFORMATION
Reply-To: mrs.susanlee22@gmail.com
Mail-Reply-To: mrs.susanlee22@gmail.com
User-Agent: Roundcube Webmail/1.5.2
Message-ID: <d8e3404733009fcceb1fe620c2ea61f6@ingodihop.com>
X-Sender: susanlee41@ingodihop.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AuthUser: susanlee41@ingodihop.com
X-Originating-IP: ::1
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_MR_MRS,
        ODD_FREEM_REPTO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [23.83.209.13 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4369]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.susanlee22[at]gmail.com]
        *  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [23.83.209.13 listed in wl.mailspike.net]
        *  2.1 ODD_FREEM_REPTO Has unusual reply-to header
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 HK_NAME_MR_MRS No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-- 
Hello,

I have sent you two emails and you did not respond, I even sent another 
message a few days ago with more details still no response from you. 
Please are you still using this email address? I am VERY SORRY if 
sincerely you did not receive those emails, I will resend it now as soon 
as you confirm you never received them.

Regards,
Susan Lee Yu-Chen
