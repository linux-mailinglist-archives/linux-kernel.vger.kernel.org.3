Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DCB587B05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbiHBKrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiHBKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:47:47 -0400
Received: from sonic304-23.consmr.mail.ne1.yahoo.com (sonic304-23.consmr.mail.ne1.yahoo.com [66.163.191.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81C4C50
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1659437264; bh=kXK2mzy82pZvXoY/dP/bBeMCh45pejQngWYJQN43WIw=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=JN1z/7c/xkhkhf/bc1SGYoY0S3e22s5GplNcdVIMNcyGhcTSmMxFl8e5/wEu4HfMF/HMH0gnZ6DvjOEl+yhZr+20WNXQrKwUvHg5Va002gQNMapdVymk5ViVg1veBP+in3QZB1FL+EgzgQZHiDWNaJPXojIQC0E4RzJZdsIylyI=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659437264; bh=r49qXjeXe9L/x9ADo0zrIDnDhjPsU5jNtB3jIDwOAEs=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=FWBtjOpMPIZZ4MF8f2/95G4QLim4VgOE2hBq2xdBJxt6SXch1Ar5Hb+B3dXE4d7kIGVnRA+B3KD5LnZXLcB3Ln4d/mXHGawQ9MiAAK9XbvM44HerDt4YpOmbFoCJ8dH0waZuOZSR2DNr/3boSAiA/WOexIIfQIGk+ro+TTUV2WPIz65XdMyXHWSheY7Q4BHrOdjI8KCIx7PB0xBXi+5yjGicfIpiEogzzW9trftPc2Utxll/u/ArLhOQyUB0dx+REsU1e1xsoMrmsiWCcECLFd69uhEbbods9e7UKpCZb2H7vRip5F/yNXkRW1+q5HppV+BdWn0SkPVkEUzh1fdRwQ==
X-YMail-OSG: irFpXeQVM1lDw0ij2v1CiicOHl87jdLQ6.0tCKs_Z07PKrEre8KsWomnhiDm._i
 5RxL2f84Al3QnIUomnU54r6ofCZSmQc0bZUL5ObvkdjqgtOpIuHnrDS1za3bmKGRP.ydo5y5vu54
 bVV52U_joMU_ZSU2dIBCcdwTWekzfOiALZPW2ebA_9eBX9HadLfPsX0di1.6xBIwGWrSuwjymRao
 bFFQ1LOvgrWINaTa532Z3F2yVW82Zkl1d87z02PDzhg2vJyOMgtl5a.p0gUziFaoqKiTyIbWuPDE
 n5w2VBagj8EaJ7VfCsP19jRuSzMh4TkBZcBYyPE1eyguBsb2C8QC2ocWezz9A01IjOIRXtbn2bYi
 pbVLJeaJRry7fV2_6zPZvSseq2me4wGHpxjJtiwSWpiiMvLkzRXk0AG8jBXBZm0WB9t_WI8fxjhT
 XZFxS_WHNJ7RyiWgDp1v7WfQFTstZtURQ5mqvODGiuv3NJrZmur.HxCINOUINPNeA367_oS.TSiZ
 dy7qqPX2E5liaK.vSjHGuTH8SYTwy_0nl9pOWHc55MOZEetVLaiFxY7J3D.j606ASDfJEbSDcpSF
 UR4ZsQWU4wfzxnEp8zAGiV0O0Ppjj2pSNJC6Yj4g9P58Wq2Bksk5YnhdN65AMll3YzomeZ1M1WjR
 mo29AKnky9MwUHQBuoqtH15A7IK0BIwTYejBkY1odQgVcoTfc2i13HiJ15kHjxAaTLNzNfsfSnFb
 _IpzeZ6kLTLgGdsciKLM_Al3hJADWAzU9rFFtjFLsVTNuL39qvyVP9LG62QVb2uMSuNqyffnlHBw
 t4sGVn3VzY2l4haD00GjaXJx51LKGAfft9yd3pmLLr2xHn1oWpbTOHM5jI3.LMT0GIQMMpMP49Bw
 6wRDk5o0V60w9hk_MhQ8pVkQhK4Q1knk1kvKOuQvM2Q.mhLqwhg8CCiUnAW1EsqNpDivSBAiuHRg
 G8u1RjFoEx_x9Hc484ilNMZoKuYKuroQ5EQpsbt1sekwwrRD1FabM3bIYPLfEmSrjk7vZX7VPKa9
 CbW07RsGUdI9cu1pG.P3kHSAr_v0h4E.ZvsnT5bwMXHxYGjc9J01tOYcgUVE1max2Cvrr6I3LY9W
 iDxJojPTC.TqfzZUT0nW0VJizKrk6Q2gbwwHLcmUoi.valtwVZwVnMGhUGpjXkSL0JRJd1gBjv3V
 LqvlbHO1d6Iz9dUe0XAWU4asDEednU2OsOHOHxZNSRLY3R0g3QeNpABFVuLJbcZR.faHkmflK9LZ
 y.JKRJWg3BW6vLV6srzyPPeqnwaWjwJu4KtqzDISNY2iSeubfKXESW8_8V2Ydj1eamlCOGIsgCsb
 4prII3Irk_..kIwQU_xWu71_hoF97589nhDwv_Uenbr_3Ql5Us7wbGiEUujwP7YMIHVGdqmBzbqX
 D1jL_f2i4xx6mGgmabvv2IuBoW3_d0etZi3bAgMQNuDytfqnp709qmho0EbMrLIu3L4c.AWLucpL
 a0GPVbm1.nvOEnRpMD4GEiYNBVPaHwXTXfG2R41NdmpGUtaG6DmxTgfyIJWqhRwcm1V_pUgkmoo7
 JR4Sau175GOOoEyLrWjtq3_kBT0_NhydaGECX8FMw_OvD6STjKn7z7aT34WR.W9tV4wiXeMs_nPt
 XcKJ4MrqSl1Ovd.VuzJwxSleOyTNQ1cU0gM47ZnPFT_19uwOk0iAXcMBAA11ZgmSePF0cIE5IVAQ
 MqLF0io8a5qXnGLeDBiXuhJgjJpcUXbxt6Z1EJWPqqtWE72XKtbt9eHOiUAlMFsJJscfvr.aW_zB
 C09twpCb8mdqiujx2A6.DUhVXOrcL_Fl6kBTLv3bi2iqEjSHoLDQ232tVGGkb5Zx.gPjvGhWnYql
 i7N2cHvlKyVtSZOwJJUJFgXyGCLGN7dSpXVAAq5Qiwtxzyjot_y.gUx702SZXOlcnhdgg27j.3le
 BGUJBdzkqzywHu7AU9_W.pPO7OXmwTlbl6XuPrigR6nqnpgEHiYHCsB.Il5XEhRNaDp4IWzbN8Ie
 NAVK.Ygtc8QMgs4A9HvF7PmgZzRQxdf3G2PxLlL4Yy3Tzy.CbAVp._PeJF8bAnSXxM4oJ4xUYaub
 qiTXy3uKaG0RYdZ0lPFeyOez1lXiOae.F4T5IqrjAlWHwuFALqQgOAazZgKLLd4EOAKYnet9NN3K
 KU1E.Z4Ugpc_RsuxfbDBiibHJMtcFN21qO5uUTd1OoqcgzyNPlbyaN0j1ZmTOkqfol79LAwEAY5Y
 aJG4-
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 2 Aug 2022 10:47:44 +0000
Received: by hermes--production-ne1-74ddcb6b46-6wz25 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 24dc143382a414b51c3e7d5d6f033ecb;
          Tue, 02 Aug 2022 10:47:40 +0000 (UTC)
Date:   Tue, 02 Aug 2022 06:47:39 -0400
From:   Steven J Abner <pheonix.sja@att.net>
Subject: Threading crash > kernel 5.10
To:     linux-kernel@vger.kernel.org
Message-Id: <1659437259.2636.0@smtp.mail.att.net>
X-Mailer: pantheon-mail/1.0.8
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <1659437259.2636.0.ref@smtp.mail.att.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 When using 8 threads vs. 4 threads, test crashes application.
AMD Ryzen 5 2400G, elementary OS 5.1.7, Ubuntu 18.04.6 LTS, System 
Stability Tester
Version 1.5.1 generic.
 Testing Pi digits >= 64M with threads @ 8 will crash application, can 
not say for certain system crashes, as that occurred on different 
conditions not used on problem.
Using threads @ 4 will complete task, no crash. Also during track, used 
64M, 4,8
exclusively. Kernels 5.18, 5.15 will crash, kernels 5.10, 5.4 will not. 
Kernels
were installed by Ubuntu Mainline Kernel Installer.
 Hopefully I can be of more help, I have not built a kernel from 
scratch in many of years, LFS, so for me patches to solve on my end 
could be issue?
 Steve

