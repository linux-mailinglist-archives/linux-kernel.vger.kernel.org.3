Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47864D013F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbiCGObQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiCGObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:31:15 -0500
X-Greylist: delayed 1300 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 06:30:19 PST
Received: from host.metroassettman.biz (metroassettman.biz [62.173.138.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF58A78929
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:30:19 -0800 (PST)
Received: from metroassettman.biz (ec2-18-116-66-108.us-east-2.compute.amazonaws.com [18.116.66.108])
        by host.metroassettman.biz (Postfix) with ESMTPA id 0CF571208F2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:59:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 host.metroassettman.biz 0CF571208F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metroassettman.biz;
        s=default; t=1646661555;
        bh=FBYaKmVy75dN2Nuxl+GNzc8EK1j9WPRyTaK0gW915Q0=;
        h=Reply-To:From:To:Subject:Date:From;
        b=cA4SwXqnRWwlLbeL25l06q+TQlOCCNOZm+XfSOdOo2TFipNYmLVoeS1seHU1fygX6
         Oj+s4CsGiBFneULiVpN96GltleSNR+TQuiInDQ6oa1tC7TghqBTyibWUaOhgEAXSdQ
         BYfuWmO/YgTdTjcTRn7bRQ3zSUEttct+n+IUIb3A=
DKIM-Filter: OpenDKIM Filter v2.11.0 host.metroassettman.biz 0CF571208F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metroassettman.biz;
        s=default; t=1646661555;
        bh=FBYaKmVy75dN2Nuxl+GNzc8EK1j9WPRyTaK0gW915Q0=;
        h=Reply-To:From:To:Subject:Date:From;
        b=cA4SwXqnRWwlLbeL25l06q+TQlOCCNOZm+XfSOdOo2TFipNYmLVoeS1seHU1fygX6
         Oj+s4CsGiBFneULiVpN96GltleSNR+TQuiInDQ6oa1tC7TghqBTyibWUaOhgEAXSdQ
         BYfuWmO/YgTdTjcTRn7bRQ3zSUEttct+n+IUIb3A=
Reply-To: elliotmatare20@metropolitanasset-manager.com
From:   E Matare <elliotmatare20@metroassettman.biz>
To:     linux-kernel@vger.kernel.org
Subject: Projects
Date:   07 Mar 2022 13:59:14 +0000
Message-ID: <20220307135914.E676751BB7C52146@metroassettman.biz>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_DBL_SPAM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: metroassettman.biz]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9998]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9998]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  1.5 FROM_FMBLA_NEWDOM From domain was registered in last 7 days
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I hope this message finds you in good spirits especially=20
during this challenging period. Firstly, let me introduce myself.=20
I am Elliot Matare, a private broker with Metropolitan Asset=20
Manager in South Africa. I am privately contacting you because=20
one of my high profile clients is interested in investing abroad=20
and has asked me to look for individuals and companies with=20
interesting business ideas that he can invest in. He has an=20
interest in investing a very substantial amount abroad. I got=20
your email contact through an online business directory and I=20
thought I'd contact you to see if you are interested in this=20
opportunity. Do you or your company have new or existing projects=20
that require funding? If so, kindly get back to me so that I can=20
give you more details and we can also plan a strategy that will=20
be beneficial to all parties. Please also indicate your direct=20
mobile and whatsapp numbers for an easier communication. 

Best Regards,

Elliot.
