Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B018E540070
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbiFGNsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244947AbiFGNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:48:01 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD886D4CC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654609678; bh=6s4jE9Us7GnHwrpBrWS9Yqnb+8P+jFhc0q4ZyDkLpeY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NyryMpuFEo36JionPvzycdY9oz7T8Kel6gnO/JrelYygrupa406a42PvUToXkwDMfYJibiWIB3xA+pIbQ5pD8z07RmX3eDCSrdBHSCQ0D3pIL8cxwWR5q0HL4Nx9xADSDegdUYmpXo8Bs+54Q7KpzvdHpzaFSnFi7ojPzKZh11rrYpKrc52WwA5ZWXPciq3LNvH0O0yLtBt9x+HCwXpcJGq+r7FB5OJYWfKTm8Ira3He7T/1VEne5JlIuIybWGEi1txfU+sRlxIl6q7u7AlR4cM6hvPgb6qkdT3nEnbBEg9hMNjbdszQi/f9mUS/uuuHWxGzs1uGmS+Rrjukx4boYg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654609678; bh=t3X/JWW7gOF5nEJkuMgrOPAOcuJbIp1+MyTWlE/cS9b=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CnGGL1S3exrAcgBjtDkx0AAH9aJcuFYyTIjlpkBj5alBnb/8ImXEzHlGcncvT1gFjO60KjMu61/RmiX3SPe0lVlMY8M+kEPw73KKaK7ZUef6ljtMmlM/fkGQskJOLwYuQbKuCtq0KJqkKtyhhTg7PAiVxgJ8jb0o5AB/B7Yuta5KxKWYZ904U/oQOJGGANo0xjJCQqZkVNA47mRn7T4/B/yOW262EvN1uOyv2O5zDUP0AbgyciVfOVbnaPPduJJ387Qyq1NDz3NY6n913KO692aVyVWEDP3RAljeeakalvsWXt3aIMGP89XPyoKkiswAumSZ0NewerzwNoAkwzJQ7A==
X-YMail-OSG: dy4q_igVM1kQhDMVg1Xsv7sgHiS7D9iJm0cy_Y0sPTAmb9x5iVvmPFvqZqVY1bg
 FU39p4Ct5NZmjnSFbKK5QzxYfPxIubeqbnf8yNT6IWglHEI9r0ahjCORFzouoWZrDuoi98aFUH_e
 bT8L3UU3Bsi1raB9jwBtwYJJiA6t9UmkoogDByYywkP3JrctF7DoRA7mkA6omluNfbfym7kMXgGI
 z_tx.Kic_r00CkGUtCP8moC.IpmVFyXXAjji61NfMf4IjNydSeXiMJbFkkimiPMDyd4sBiUX6dmA
 MAu50e0pnSrBinTPUbKpP.ter78WTg4p1CYfeXxQMvBW6MMnw39_8z9tM4Eg.I2dFm.ZXQbbLgjH
 p8Az4L_0m80XbAmY28g3vckaPRH51IWNc0JqrmvJCyhYhDk8RbhmhKKxa6KhLIHAcrEzPG99nOj3
 DI8Qs8LxeCtk.JUnbFOvWCRGtiVlCdFzsl0Yap5fiBWGT0oCXkj86XCoySSCAWf8.mHHevjscLel
 hvl_FEHqm2PRfmHMRZNPMNdHn9xHlP0NfYXu1QQXFUm9Iwweu2cuAf6x8tqv4TRxQ5am2G3mV7.W
 nBZySjBzr7zxakbXKM5iDUUqb04qLI1EbYZWVpw5fZyn2cebhMFSYaYDdmvGfktyPnvu.8wQST1_
 PHElStcg6p4gCMbv4pxnP3QIWsjA4plDjz6U7zvovVEnAaDwwqmvLI2rv3qnHN26dTaQNOyf8Sgw
 ngw9Vi7nBR4ZPSfi0azBtKpgerUYYAKxfeakXyQYftFZWXAc3bnAcdVoVGagP2C65LtgfVjvVk2Z
 ctZKSdqp4W3fGX4C_33E_palLOLzbseor5vbj.cwAq1n8ef4ApPmjKL9h1.h5cBddYGtlQPRHPlV
 OV6BSKx0NwvNmYaTuYqA5Mq9i4GkAjfZfVn0FTnDfk4bHdT_s1DvPubBBFw0hUgpI2nH.x2WG.Kl
 sdTzZfI8VPM1iR2ED8LBadOU51HzW989eB40Vbc_u6q7DZ2huNESX229GZJpOQFcEvEWJizrna5Z
 2G1XuMa9UVxaDL9l_adqesBNQypIsjuzKnjKEwzxVMGnLqLdmzx1xBmojYgMxBOfx0j9wphyky6n
 U0gFdLLL.UvvrN.rutbD96CYjsDdUaqiifSQxYVyQHMZJkU2K8awlkXan3AYyZwScLFC8DK1QM2A
 fCl6PEO8eCT0kjucwUlEGTiEDWsN166D8NS6uVxqvQruaYpnUc4Z94iLu6IQnadTsu0_gKZJ0Oc2
 GE18PENIOn4qnv5COThktioLZ6QQLRjbcG_I5YBonVSnKoVu_dZRWVh1yNniCQOVNS_Hak5SnW4S
 D01WCIU4vKcfxC7rNRU2bjvibGR0ICGBqUCNv2m4AKp8ZUTUiSopkhbQDXr_oAEURO8bt_wuY79S
 RqbxAIKNCjyGLCXgcGQztLt6iPcb1qlMlO.UAooyUkASdPsdCzOYY7_u7SBKtJHEfIE367pyIrxZ
 vEjcePF1suUjL68JkA.sQ.lxhM3mlIYJjPOWLt9nLggKd2yucdbsrc_2n.Y.tuVCf45MUdojCI4C
 IrMgusIltB3BR8RtGeNFj_p31t46BcI7JIgTQO.b7gwJvZ70xh.dFpieLPdRYyqNoBh_BG6nYdHD
 yOMGEoFs7TU_HtB3bPUz7dFucKXx9x8XnjtxOLLq8jHNWBKRNUmer6kLn6brxzUvutjrFnm60car
 5G5LS.cwa8fW6tZbxLxsTEp9fsz2XMk7TY0oSKjJRQ655FlQ.hJhm5LJiLeMtkpbPTneE3PxKU8Q
 v6eFvXuwkYLSRDV7kuAHr96yaBR3kFpUBj2FoI4TlCGwqTc2wpLWIvLxEQd8a_RDNHIfOpjK34Qb
 AoA31P_cTLNI7fHpe5PjZXkTRr3QgByaH9.j2_Lexc8Ko.n7r6RclM6K_hoHWeRSd_ZrHioe0fz7
 _TZiJ7bvn1NWfI37qH6hCQZkkNxhsPcBaUhIsWpbtXVP0PDCMhWuhcSeqdGU7DJULbIhnzDuQTOu
 VcGV74kxCzpVPGXWyfW24PXYf2l9a6.96BsdzoLnXePZ63haiIPRhZYl4RF6etuLo50y2k2indR2
 UiZ3K.RWbXsgkhy6J0jkQ8f.VoVfBW6WJg5TYPfZnGuSJDXFDMC3z.uQ_iQ2N6trLARSxT.BlmX9
 D8x0ctoMgWHNio2yxJqz7yLrN5BjY8hBj9JFUCyaZQL.Oijxlg3Dvsk2WqLOAX5k4F86hFsZnY3l
 4IF3mFDJfd1pwBI41CJBKqh7dZHwSXdFxjaXymQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Jun 2022 13:47:58 +0000
Received: by hermes--canary-production-gq1-54945cc758-xfztc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 19237ea258b8c46024bfa18b3f1d8502;
          Tue, 07 Jun 2022 13:47:53 +0000 (UTC)
Message-ID: <8c451435-4609-55a6-e92a-ac325690234b@schaufler-ca.com>
Date:   Tue, 7 Jun 2022 06:47:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] smack: Replace kzalloc + strncpy with kstrndup
Content-Language: en-US
To:     "GONG, Ruiqi" <ruiqi.gong@qq.com>,
        James Morris <jmorris@namei.org>,
        Serge E Hallyn <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        GONG Ruiqi <gongruiqi1@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <tencent_89197B737354F02FCB2E31A385E2BB696405@qq.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <tencent_89197B737354F02FCB2E31A385E2BB696405@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/2022 1:17 AM, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
>
> Simplify the code by using kstrndup instead of kzalloc and strncpy in
> smk_parse_smack(), which meanwhile remove strncpy as [1] suggests.
>
> [1]: https://github.com/KSPP/linux/issues/90
>
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Thank you. I will take this for the Smack tree.

> ---
>   security/smack/smack_access.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index d2186e2757be..585e5e35710b 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -465,12 +465,9 @@ char *smk_parse_smack(const char *string, int len)
>   	if (i == 0 || i >= SMK_LONGLABEL)
>   		return ERR_PTR(-EINVAL);
>   
> -	smack = kzalloc(i + 1, GFP_NOFS);
> -	if (smack == NULL)
> +	smack = kstrndup(string, i, GFP_NOFS);
> +	if (!smack)
>   		return ERR_PTR(-ENOMEM);
> -
> -	strncpy(smack, string, i);
> -
>   	return smack;
>   }
>   
