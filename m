Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E14A4BBD04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiBRQJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:09:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbiBRQJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:09:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E0E7F71
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645200519;
        bh=MRyFDIwwAfIPkkcyDVDGrNn3Seh++39CRJKoEQM13Do=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LgydUFyXTIdP2FiipNrc+J1DbcuwzvkPXfquagYbdc1ln5DfqXkw5egMjFr30ZYfs
         ZLMvPMzd3njSy3NyADyx9IIHgW4BqzCOojynMF1nevS6PE6s4Tw2A73GTfdQB649b/
         dXdJt2XT7Cn/I6ZUunYKNIc5LRIaXxqASkG42gcU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1npKHk3xhq-00VTA2; Fri, 18
 Feb 2022 17:08:38 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     "Joel Stanley" <joel@jms.id.au>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH RESEND] MAINTAINERS: ARM/WPCM450: Add 'W:' line with wiki
Date:   Fri, 18 Feb 2022 17:08:34 +0100
Message-Id: <20220218160834.320200-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yq/8qcpxD5O6jVZ7ZxGNZgIVSzb8peSicYUoPwvZllsj//xQkZG
 aD/nn75jFtAQobh9sUQ1IEAeSG6bbNG898SFkXJemb78OOch+VRY3ai50+pQzLQr07Ko0ze
 MEZRZTffvRlP/FJZ7vPAaLwgDQeQstVdtTOIgUorPsDbmGiGFtM2/NcavOrBNliuC1IVgDo
 2SwVsYbOMWyBtVTcF1frw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wzFRBRbt2mk=:6T//iTd/vKppJ+IsHCb7NR
 JKExUBxxiZK45uFFBMAQ0rV/MdrOmhtGpReONEh1GMg80n6+jIJJeYPYOckuXqYA4o3hVeyTa
 DzbNPKWOM6a3RrC6DHQftaZAHWzbXzPCg0qJV4kFnWpjtHNW7WHZGnzOXZTeNJkIHT6fHd5AY
 wR+rIb7foG5UIuWRwM9QGfY7RjcUuAgM8PzT854CU1n4/ZgmNy6f1nRyjZFc8/46P57W5kodc
 lAiUa+vnYmc9Y4ACeZH1l72KPmNI8v/43EDugzlCYZdOC36T6yq79JArtiUlmiXTPK896DxBC
 m7mqcfKi9LubWfUfIm/Va3r9OXjY3hpQPs6PgNbxIlWzlBdsrNf6bfV2LDjiXUad+ktgejiK8
 8Or9FYwT55QmEuZRg+EdhG2sWFtYhSP7rW8ylwv//vI8NNMzaTbLowjkjQnfTOn1EZ9j7q5ao
 PfTdvylhbI3n5EjHjbURvo62tyOffI7eyZQdsR48yd2p4vVFykTQG9T/3p8DDKmTUbC7AsMx9
 9lwNabPT45SaSZFp/kDEuno/+l70ysQFb6Mm12Z7Or2UrfQm+qQuJ8YoNkzHYoH4sPmSBhavg
 cHb4IKz1u1ik1Ts6Wo1H0s2uIR2Wi6pdAnodaneXcWGdfjNApD8uRtYi1HMzScmKBNHFxaumP
 7RSNF0/I046ZdjS34vRzrFTN/6WgAyvvsXlqh6qa6KYQMwpRj60arHojyvFdd/Fq2YRuGM1F4
 zMgcmrd21wYkFe5e/shy2B7rz4S4rr1rhY+Rxjed3hFbOoKsbz6FVaaJlBGMjP4ys028Deggr
 NBlW93FGyTfitKkJp2lsCBHF5IHpVFRpTkR0koEJfjB9GL6wury9KHjRDKYy/IywklYvS6SPw
 3Y4McWUiTpjLbd6eEZS6SVXY47I85hK68cFb50pld+6+nV4Jthfo659ql3KMwmR02DHV0jMlU
 2NIMhYrbaWdbmW/9ktLGBQKYB46Y2Xe2ou/uVFUifFGU/P6EtFSfcFjPp+gbCGsGhN2x8FbDh
 JYIpULIC8JWIXoqc/KF/NpeqkZmCXCpecD6ejUMk3GwTIvZB5bkr472i4wC+7zUq+8JgEIh2M
 UjpkD40joc2L/8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wiki is a useful source of 3rd-party information about the SoC,
mostly hardware documentation.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fbbd9fa88d86..39d9e2c6f94ac 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2350,6 +2350,7 @@ ARM/NUVOTON WPCM450 ARCHITECTURE
 M:	Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
+W:	https://github.com/neuschaefer/wpcm450/wiki
 F:	Documentation/devicetree/bindings/*/*wpcm*
 F:	arch/arm/boot/dts/nuvoton-wpcm450*
 F:	arch/arm/mach-npcm/wpcm450.c
=2D-
2.30.2

