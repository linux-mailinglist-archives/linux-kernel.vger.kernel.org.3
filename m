Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3BB5370C7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiE2Lf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiE2Lf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:35:28 -0400
Received: from sonic306-22.consmr.mail.gq1.yahoo.com (sonic306-22.consmr.mail.gq1.yahoo.com [98.137.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64C9A9A7
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1653824127; bh=RRgJoG/L4BQHnc1cT7FRAwecnMXwJlauasCSmqnyPAM=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=Fboj+JvTxf0ky+/oYaQqkzG43VBGoM7l+ewOJEENxaaomc5ITi9CS1vv1Im/X3+yfvXmM/Fd5ma+N+7TD5xUYemXYodC5IRIV/DlRc8gAaqhE1l6Xs9kbDAGiwUuzUjyRv4IbkkSEcjBLVUTh3osjLLImZQ06+SvopbvY9xGNec=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653824127; bh=nMBxSXruymYMWIVmmEPjdIlj2p/vMnVg3Uy6ZcpoO/F=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=jhRLL11SWLe7XzfH4wFjmae1+JL/G9ZfLL2L/3JILw3fM3auCyzKKEUTzK3dic5naJ/Pn9tvOG6H8R1+duwRsJNalyISb/Tped8BVZ8wpUJsEbV2azkpluSeNjj5tQry7/+F6kaZaV3BOVzO4HVmljHycL/q3ntEUsnmNDZB//khotyXc2Jn5n2mMcKkEd1EaP8jzJCeaXiIfwgB9T/DxLPjL47zU5Z3aj5s9GghAmww7xiPwdPbNLiBnB5WJArMlZPwYqBZfFgfWFMva115Dr0UXS2wP1yfHMeORqd66rEXZTmI2Kym+/yzRi7vo15HlZaKEMJcqWaGUEj7q36AHg==
X-YMail-OSG: qsc4N60VM1lT.voDuqyBRRP1chLws0RRccxiCoSARPQR1NQGe7vq.V2jOKl8.yu
 CnNuzfZiFb.j.oflBgIkldvk25vQpTQkccHOR9ipOybHRZz3mOkM8lfqdu18TmOPXY8OryY8_SQn
 myMSq1sTgjxweLf13f.6.a2iLbPyvwSeIR3nz2yrVZ0F8Pdqqo74HKTJ_AJNMnOpPlZ4DYYEqFf9
 0SESFHFRHhxrQJEmUjnOLMfKGmxiOhBJI.mPqOkkxwsRkAvAXfsky3M7h67VxpN8nHFp8lDGrEbP
 bRTrKhEFALMU6b5rVIzJCScJPmCpTt1EpYINCYHOQZQw4M2SG8b4yx6AEoamHDNPCOisvgNsh_Q5
 4dM3gfIrLuYSs2yyS1izDvAn7a1qNTxYWYymtc0ElZIMyN8Gg0Rq7g5BzJBdF0BQhY5uNCG7.RUM
 05ZxbjzPUplSf6v.QPf2e4EPCejx4IjMD0QI_qbOmeAkUgkjj45ZNV0pjoSrd6fivd3iA0rdloOZ
 X6BNiIz6sMjrXe_NqnFxTljFXZeIVkimDQprrdkt6jc.ZDglI.fwWO6Td8T1HyhBvkdHDY5kztMP
 YMufZrX1nZKp7hEfXf6KKrdL5mnsRjZPUVvgSj25XhILDkiy14veaTK16VQ.p6lAxIZG9aonBKyl
 wOqAkRLFajyR0D0RcQOSVZ5Egpqe8epMGlQ4o1Hk_r0LMMZZZJ4G6sJAUr.agrAvPfr_GvkYmYSc
 GxPe5nr0oaVRflgRvfN2RrYVvG_QgJxKDZ5hp8IPyLO5q0GQojq5z5zzJC6npcC1vOaocoWBSzUb
 7MzmdMiRiDD2GjwKIJ2UUs78YrS1ho1GXCm9D27_9HzmlbVs5hJMdsHKP9m5hsweK3Hmc6NT.Qh8
 JlWd8nSeNVDpriSo5z.GdGvxVYOHTIg3hIpRCmMBCUNKj5C_4GNSf.uKabEj7lTGSVvgYngrS1Fj
 PJ8xhZzFGmX6fbSbbX1hNwNUmspK1OifXFLSB8vFluy3In_m40gDWlXHIK1MlwKdbKVAPE8bn5A_
 1secPW6u_hnH7ywV9UV_VQZ2so000eehSE68aCdlO_4Y71uG6PRU4Q5ZKoWo0nGijrJEwPVSUDgk
 5brDVqn4y9fhQUWSCJ9j3MuN9rsbRNN01KwlkUeSkp2ncC8Sm_qvtzU1AfctQ3Kj_TtoTctTisrI
 rOVahfHY9v5r.lGTyFgM1w_op3SWCYeZ7RfzQAhAWsIPMEiN7_pHH_XFfY0gDhWmqoKPI9JdrBpv
 cEEMvqIvKboqAoQAbvqbMHj28s35eze7MoogFSGkrZ5jklJ..6p7KEEHnelNe6eR2GkuIc9snUhb
 3gCC_QA2v1DSizYgz973WpV2tSae6d.cHh1A2eLB5vfn02IIGX4C73I05K81gJY.zpG_dz4ndptO
 .D3KaopOPctIJd0BUJVXWtF7IDt3pYEFeX8Oicm3X7poGcMVLW2KpspRmUPzB.kGB1SeKznw0o.V
 HLyeTMf9On8jEFzgm1DWSGGUjEFcpzIDdBfINwz5r3cEgEaQrLHi4cXU9vn4GGmmcgsWtA3pZlI0
 7oyr3PKJR1bSGhGD6DYam3RI2a3Z7CvBAorlOcO4RWnkaZiUFLC8a_yDoxTJkkl3PMx.vVccotvk
 EZa1fMz1Eh0YIQvPZHBLGOg7nMVBR5i9JAImVmfRCzNLJGH3gDRoIoiIN0gFCfWd6DlLrmCuZvxo
 B3BEKJTUEqgpVkh2BUXnMyUWV1FGxMMevDPXkemBa4R6TisAwzZX_ki4B2TpDS_88OxFyynH87oq
 zcQZ49eVsowX_xeZ1lXvru7HtgbmTLcUK.TkW0_Fi_pQt8qgDWoAMDfyUGnUNGr6dVWV4iu3TJy3
 c4GgkfKyn6UUepqNvpDEgxZqW.Hk6oMkPrTeGmEnEnjmJwH7xybxFUdbt_DANMIqFSM3BmqD9Hab
 Dh30NF4.OtS8aFQ.8A6ucQ3ns0j98WDxzZMd7YHgeCr5TtaWt4k41GI6UrGlS1g6x9DRMR8.H0dE
 5673l1bkBFU9vLWjzmHX7o5SR6u2xXqjp1p9.bCZkYT8eADE8ZKmqwYjw8B0RiBFEVwaXGit2NMt
 yo4ZzL04wfQqpJg5F3NMbF2Jp7O4GMAHcv8Aa0mLlAKthMQtsi6r5Xx2Jt8QrlvYWHZnwI2nhrii
 E8uFmfeRUunCBlwEHMTb3Y7RP1UK0nNh3hQyz3g0FlY.judvSwpeC6UIczaGFxzF7ReSZ1wpT65G
 Er1F2CTBLO9jKhA--
X-Sonic-MF: <lesrhorer@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sun, 29 May 2022 11:35:27 +0000
Received: by hermes--canary-production-ne1-799d7bd497-7z8w4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 45c10ca29e34986f6be115ab68704028;
          Sun, 29 May 2022 11:35:25 +0000 (UTC)
Message-ID: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
Date:   Sun, 29 May 2022 06:35:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
From:   Leslie Rhorer <lesrhorer@att.net>
Subject: Modules list
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	I sent a subscription to the linux-modules list which seemed to be 
successful, but when I sent a message, it bounced.  I sent the message 
to linux-modules@vger.kernel.org.  Did I do something wrong?
