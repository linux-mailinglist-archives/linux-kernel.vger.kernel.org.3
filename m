Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC754B862
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbiFNSQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbiFNSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:16:09 -0400
X-Greylist: delayed 2519 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 11:16:09 PDT
Received: from correo.hdv.gov.co (static-190-25-223-138.static.etb.net.co [190.25.223.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD119F80
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:16:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by correo.hdv.gov.co (Postfix) with ESMTP id 9C55218670FA;
        Tue, 14 Jun 2022 12:11:17 -0500 (-05)
Received: from correo.hdv.gov.co ([127.0.0.1])
        by localhost (correo.hdv.gov.co [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Xszx4HeByj4E; Tue, 14 Jun 2022 12:11:17 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by correo.hdv.gov.co (Postfix) with ESMTP id 233FF18670F8;
        Tue, 14 Jun 2022 12:11:17 -0500 (-05)
DKIM-Filter: OpenDKIM Filter v2.10.3 correo.hdv.gov.co 233FF18670F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hdv.gov.co;
        s=11DF984A-9D1F-11E6-B193-F2669FC4C452; t=1655226677;
        bh=tvQl5Cv0ChD6vA4I/J397OSiPoTe3zGLvZkAUXlzids=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=Od5ywIoue76qbCuRKDHPtjKcRMPrcBH/0iLMuxdIHcfHxFAwIveXZgY9+1V++KHlv
         0C7fAJGhMaODQ9dNo29vHVnnbmjFUGmMUndBNPoPD88nLdtHev4k1CTwbxToi/wB4w
         i8Ii4lELFwOEvWAzaJobhkl6gh989mrotsVtP6/c=
X-Virus-Scanned: amavisd-new at correo.hdv.gov.co
Received: from correo.hdv.gov.co ([127.0.0.1])
        by localhost (correo.hdv.gov.co [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lrzSk15eUsnG; Tue, 14 Jun 2022 12:11:17 -0500 (-05)
Received: from [192.168.0.103] (unknown [103.42.91.61])
        by correo.hdv.gov.co (Postfix) with ESMTPSA id 1D8B318670DB;
        Tue, 14 Jun 2022 12:10:58 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re
To:     Recipients <smental.obsurg@hdv.gov.co>
From:   "Smadar Barber" <smental.obsurg@hdv.gov.co>
Date:   Tue, 14 Jun 2022 22:40:40 +0530
Reply-To: smadartsadike@gmail.com
Message-Id: <20220614171059.1D8B318670DB@correo.hdv.gov.co>
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [190.25.223.138 listed in zen.spamhaus.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9906]
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you doing today? I'm the Chief Executive Officer of the First Inter=
national Bank of Israel. I have a very lucrative deal to discuss with you.

I will await your response to proceed with the details.

Regards.
Smadar Barber-Tsadik
