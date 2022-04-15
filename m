Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B735030CD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbiDOVrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355331AbiDOVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:46:54 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E6B1BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650059060; bh=C90cKiUyo6RDIWVc0BJk+iAViLhgoMcefmkDp8cELM0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FEOEC1d8gm77GPM8jhtLAXOQ0tKqe1pvDBYIWWdN6SdhshHpGGG5hZq+QjfbGd+loXalBgoDh6YPlQ1xs5/eT/bbTQQXtSyEeYP4LX1YcfzW8DLk9hqg1jOeHTVgGhv0Y7IJsKUtiZUTSocVw2YWju1IjpWTrCeETw+sE5miVqbmLIyb1aepfrZk2GGwp+uLUSRXbk/naTYjpWkLEkG0qG0PeE1bjvmwl2y3vCkF+yvmqcb8OhqXdIfLysyc9tLRplRrCnGiUCpNgnCcmvaT6SJ+t1WdG8EHZnmqdgAwvGKKHodsdt5oFcuWvi0fOXSKx1/c/bXxLMYX7cNXfVY4bA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650059060; bh=9HzbnsH3+0Ye+7rrFyf7m7JBfJc0JDc/ekrSGqZ4lEA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WvU0g4p+HTy3w+MF0WDLGo8LHUDfYur/5HHdlQFK6gZOy0Hm/XAwxEXp8fxfOu904kAgON5pZVwmGfj53R7skY3kSqMo33CrWwb51q00aOlRNeUG/9QDi9klrVx+gnnRtHclY7ZSLA91wfZmAs38ja7llvKIChRp80GyiZC42GN5/enWp4c9J/1zUL3N9Ci3+BSpm2XHsZ+hjRHEESV1GfTeg8/aLI1VAOkr6zAvmxFBVyL+rUUhExcuW/4OpIA9oEVsJ2PtmmwxSx+PmTVoCPqsjEkNEMKuF8Sc9PXVIZpRXIM0SUt5+YOYT9rzxksMioqE0bk3eAOrMDsUEvZbgA==
X-YMail-OSG: SwMfnsMVM1k2gf_1wGaMvMhBRki1VeLlDnO9Ah0VQfj9sWoMDjW9A.JqreSg_7B
 v6g_O0ujs3I4KTfpCBXEPdbB56mpjrHd0y0l7M6v_k5a7a5jWqiZ7zVEelst7JYfMiG_jRYo59TR
 sELt31PmcjAwjEoAW5yD.b.jS5DxOS6NXBD4nEqev33En.N.vzIa4I1h9iFB1a16O7b9wHF49aDz
 Srk43tguU3Inh0PJjMdHFfzEdL39NW25vTw_lZoCNC9xKfkuDXNV0aX5viGkA4AtpVZAF5EPYLXB
 hVgDedSNkVkQXE_1.X7FRi7f1E6rB4LK5WJXH6XPFTaK8TqEyeh7qJCbdcGeW7U0kS9t5dgYnC8V
 6JgJOvGVWKM3jLUCgw3YDBJYmOCRdMNUi0QzTQViqH9aGjrBXUGc9FawMb5QAHAC.rVO29JMlNFY
 _CuwidHra0vIZUNrFLKo9oT8Pz92.SoaSXoqUwBHU83bf8j1RJuwcNhsvhnP.ygGrApr3ZkgCSIc
 fwji38Yr3iUnXwZUONmsilCkywyeQ6ZFF2kOBttaBiT8MxkiLCU.2oiSWfbWxAhR3KIDbDIIB6sX
 yg5aMTX_gDneGyjZ10MzkR66zTQJH9R9_LvIzogsvXOQZi5t22ids3_YL06dVdfVAswwOBW1tGN5
 JA1MruVylbMrkONNZZebIF7pXvXx3VXjqj7XFDCdiSBZYSoll_2wO_l58SSY6EydcCGfukeVng79
 jETgNqA_J9MlTPaoM9G00HD_pWjddJlYuN8V_6uvvln5WDzGfbnFX_910pvLVo5WjYUljiPWuLzt
 fdtIz0nPoljjhniUr2GSDZIOwFsjvdzU6Vi8A6SVBUGAByle8_hJPCqtWQPhCMCGmMgHlBxr01TC
 x9cBYipm3Xljit93G0lboydOxRx7wsrUWDdX8.D5GaSGn0ZCuV9Gm7hzr687QU8TUrSVRlO0nNcx
 P.Iin0pGKc_lh.TXQXB2CbRh86edgDufPw6f0T8GV2IoSoSS4vsK1q.0_lo1FDBC.w_GX5BogPBN
 K1lldrRt0O8g6AYOaVHU1TGiY9wVM.wjnuZG.QZ_mUapqxO6b_2N8eLRd9O47QVhbfI3toslR7Wh
 rRp34ytY9L_QdwcS_jKBsNyjHKCroMx50n2cwTjEQ0fkCQWox30kXo9FnMqlUzR7U5sV1F8AqrYd
 v4heFec6mnaSpW3TqR7CLzxbJfYWLeYCtTKAIJR14pmAItzpHi1lrWlaP1KLFUFrcU8ygTGYiEWU
 KlbyVqh0vlOwNJxJNIZvu.SiLk2Gz._6cuekO87h0ut6oEULZs1g4Exl1ufZVAJaY5fhrqj7j9BT
 zXKqR_6rbBppjx2Gdr5_r_Nj8WEMKGpYTJMU6DG2jRRu3oi4ayUflfQwQvl4RL8LTuibvRhsus7s
 D18VMEbFcrY0nrhgNskU5Gj4kFfLCRsaNe4M6f4oAm88P2Ofyl7EbrbbeYeRTC31cJov4JMS7IBl
 SxjVZJQ1B45EuLqYcU7cyVsCBYmtLZ2xORKeARr_dqREfaVIFZooEhb0ExeEWgM.ZnTT0ikfVbwG
 0Bj2ho8c0rs14leMlrupcUem09ni4XUtarKJwoaWa0YWXJUyX0D2CFK.ByFEH9Eevhlj5VJ6qxzS
 YtAA1d0rc1IFT_uwfuybMLfEsmVXr9h2gFU2gnJXimM10xclqDXSlp9LeXRMo.OQuvRiC0sAlfgw
 bu_MNfI3bb29GJ3JH8Gryg3UdX31TVQrEOAe2bVS10j_M2srYLYMCe3q1xZMPSGzTwwrf1wH6Ahd
 A544Jq5rRbqelvg5DsRmvQbAFQDGvKHlH.EEYajal4qUYSP__hAhjQkpWsOcwC8Obr_qB1ry_JEU
 Lx0PRsjHIZvqjXMgN9sRD1elvf7qy1dQJLC_7Sv86htBGdAQTD1Ftv6CdyNGGObXGqvVBfHpnrcY
 hQKGvaEluxYcJDuBhtHABHnbaB2YvW.jwwOzWENX9BDWimNvswizJ1tVO4YhhdP609jT1DFBw9Fq
 w2obc9S.lWecJmohW9f294xVr2zs4.QudrnNTfUktNpMQUFdPwbzHjommZS24gWit6H0EqRft6c_
 4UYAZKr3MHaAzzlUCYZrQpuAUkLX7sreNtIStYj7NangYyGQ8bfR3QB4lSq03dEmoQu1QU227wEJ
 J9QEtU3AR5iUJXxwd.KhLmyruPYYVSxQGzoNPb.QESu3MrtXSXvx64mLak8QaNxinAu4_4yThjif
 EsUsziR1Q8tBVcs5BeuJxk.j0VZjSUUG1DtubzV_eAlSh8XuX9mKAU7Guazy15I1YjhQK
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:44:20 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-xjccz (VZM Hermes SMTP Server) with ESMTPA ID e7b41937d610f8e9a7a8a415c19edb07;
          Fri, 15 Apr 2022 21:44:18 +0000 (UTC)
Message-ID: <6558813d-e66e-688c-d664-68e00faf034e@schaufler-ca.com>
Date:   Fri, 15 Apr 2022 14:44:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v34 00/29] LSM: Module stacking for AppArmor
Content-Language: en-US
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220415211801.12667-1-casey.ref@schaufler-ca.com>
 <20220415211801.12667-1-casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20048 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/2022 2:17 PM, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.

Apologies for the inadvertent resend of this version.
V35 coming soon.

