Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D7546E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350124AbiFJULm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347418AbiFJULk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:11:40 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C933B3F0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654891899; bh=//Lgu6FNCj1OdZR2z+ecuBjS0y8kGKR6qF1xrMgUGG0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SB2dukGKQSL2kZ1VwAokjUScLXWVfF0/a1NTU3Rlwh+gVNsjXLJLqWqdwzw3Qyl8yo4rcqip/jforjoV3v/xhzBxFPiQeCXG91BtozAO3HxJpaWGIrj9SUijx/p0jJ1J34V0+PBwxosleYpr+3D/x+N9rTYqRtx5Rm7oDIXfnISNgJVl7V/SGQWLuZzy4mDpBMCPWB4AiS1H6LB8deKFsRU0fyNHIWTlTmlJnumCng305G2aI1B71HLEC0XrqDryvmPtFiHShPraTDVoERx5LdqsrlC/RhqaO4UON8QpI2CG7U7Et/ndCbm8YVb/0vvFuNFJV5fWmLKFSYg4d2WqOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654891899; bh=cZsuKSfvppVleNqLP2Re8xVsq8A3iTDLhOaNltDn863=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Kd6nvGlcJl+A4aWnG9nXxzQ+44ZhMXwbx0Az/EEbRkNIBde/myqfJCbJo6cnGTPeIQru6jmKLWKdcqzydZEFvzUjVqs+gMLhamEpVlenMv/kcm3KZDp8vRuUf0bDFKwu0NWGA3axzYQ3nAaN01wSgU6iTjQLDEMRX5JFT0b0NOqHkHyXzINxfpQNtPomhu6SHrgkXXP/2F8qUqxvoZ4Q1MQVvB4RyJXvM9cW0dCOsgdMeUiXV1ZPNv6As67J8O8313fSCrdPnDmBkOpZ9NXqVWmLBLPGUAZV9ZItsD+MQHYMFfifSwKlifBaFntGTUxzljCo57eWTd6fHxgq9dXwNQ==
X-YMail-OSG: 6PWn3moVM1mGZX.HN4U9CaPheWTrVSDOnsMa5qtfw4iDsW_yd.YO15lm0gkdLzn
 ATaQ46Ww4Ma1AyvzUBaaVm9l_VLvnJU7BwVb1.F3y3EV.6Zd.HqQ83Kr1r5PtYat822xMMsikOCi
 0syVpfPMKPA4CL0qTDeuExHW8oM_RQw0Wny1.cRWLIktvWEXWeVciDRGdZrkFU_El912XBJ_tZHh
 i0GhEsLDEHjKHve4DLg8elWrIBvxhReLAarfLCCQ81jA6ePOETNGGfEKuxmQy.muwHhBH_xNV0BX
 xJWk62agDBMIpcM8ZJ.1M.bhK.kP2xyX7IWRFgwHT_WM9..nT1KX57yvdUtB3k1XErGtXKCoTYIF
 .wPONkUBZ.KGnYFz2DT9H2.gWHs_fG_gw1OewcI.zUC3ev_ScSj6ZyXg25YkJvSKA3uwupbUom0k
 zeZyFnBdPC1YaaE4MvN89hWr9aAm.7VqtXnWk0cdUxXZVSchFuvKKUOgSFZo1UauSWLi8H2_FwqX
 nJ4MCKbvBXmjPdNCLi2UDd8pUZdP6l36u7lF3VKYPn.AqNCMNmm7ZAOqJCqZ1S4tUUT6Gb1KDS78
 iqKPeC1j9mnU7LXQpuQomPspiIGhZuBfB6CW6e0rYh5FwjdOwR6VnCA9wlJHZvCS5p7YvhRqt.id
 TWZTtuvSMVg4S_5e1rzjZpgsTvd5S2gX5OfgJDtW7XHEaS9jkJ69Tq7VwoFuzo.Tu1gO9nYuvPcp
 EiNVObrgafESd1pm9fI1rsMpvf7hoQIGrRbxomJlSKZ_l.lEIG0I6gbF9bRErIlWUEZ1cMvPSnmM
 iXl4QIGKgmXzM4EOBnMgS9v.6p4DVnCm5mxItLLYlBrWEIHUEpKFc81D5jZdb30BfCGiiNcxVeA9
 fsefuPdY6G3cpTUDxW04YdqsmEmy0qdkOHME1yLst0SMqE9Lpd_K.K26dlkqpdHJS3gy3tead84g
 rm5V7LGRCpQtVAFtpPKcMfwrlKIc.8F9Z0nKz2q8qslGJAzhLmjebgKX9laHskDMueqsaaOBciiL
 jKpluiNrazfPriHyCP.ZbZA23BjpKkdtSHZMLT3olI9mHJvbFeuJO7l1UN_K.f0RNBIEKA4SdDII
 RoskakHEUVVIiMerGa_FbnPprstXOG4gYL7mIMyI2IwphADJ.ZqqQUuXk80d4wMI4d72N8ALY1WS
 PAXFhNin8aLqvTxj0hTI49Vn7B82SpkJI5ob9_VaS0wXJ.zLhIXrrtsxlBORqMN743xZiBpco2SJ
 JOEEUHvB74S3rXjR3FSGhlhzDnQiKMOO1o2h9rQNsLWwzEkrmLbBXGigThNBJleppDpN7vvETZav
 RuebfJ8ovMIVM4b1aDYSujc8bCynIs9azyp3.ku8Dwi3YrgcAvk85I84Mbuv.aAurJ.UoP2g22Qe
 97IEZZWCS1cD7B..OdkGRwB9C.aT2lDylOeb7l.POu3piEMW1Kh79C2gOgBzGCyNrAUAqBNuxX_x
 4kUVq6XPK7ZEtTApbyD.unl252fko9b1JpV2hK3iPnqkJxxkKdcSW6seWHauC_p5KG6CO1r_QfsP
 OrXd0w_t.UinGhSbVVPWrixVg0vOmdqTKk0ZnmahTrtHwMuOkrOY3jROhP89H1vJr1oWIU0VAMh.
 baiDkoerEPq2dnfLarvMZiDgMWp36ltkIUIv6p_hs2i8tZmxkUaWqsarYCa12bzLkKGvmqSwzqV5
 tsVdHktOPuU7qYd1YnWztDCmK__5.V5.IOlk_iep86RwP5tx1HjkH9hez9UmuJ_c.CbnVES54nQ5
 zTfmIF82C.TJogfcEanTpTlLG9UG9UqQmm6wlmO.Q4TGbrPvpt6n_sMQkTU9JRrk4H7jBae99YTr
 8CncT6UlZwRUpq4JZWDQ0KtddyJAysVAQAS25Ekx4G_nuVVBoTqN3K5ypNQsRCv24AfLl_5sXjcI
 MQfKwD39G9ps2SqJf5IAXdorRn9FlLlo3HERlgwcRwoap0XCXZfQ2oaW5Mw28DwzKJcrhhcYiRc9
 Dztn1D3oG9xRkuEzPs_1OoHD736L0SObBRHyk_csIxTVHTUgUtcJUy_czXnEk_CGr.jtzh0ai8sM
 Zfc5RCC5IRPUQWxdgMAFWdtk1o_9UCsKkW5wokfCVVU.l7Dbk2FfwPsryxvwm5qv3jN7LYMkasP9
 5witT69filpjfvtEIX66Sdx59khFvq_y2cXry1icp2T_3AjUoD82BbIUVEwL6kOxb17k_2_YIi2Z
 Q2fOz7zpFwsK0Vm7C99vqVao87k3J4AHz5_9A8hG.wCNk8LXyDxllZMCaIHE3oLrzhXTiOmuJw5g
 fuERPsxGs8LuKXYqxlW5xEl7va.GI58Kr
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 Jun 2022 20:11:39 +0000
Received: by hermes--canary-production-gq1-54945cc758-2bxrx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 080d6361399dc7c2051a9e68bd9c139a;
          Fri, 10 Jun 2022 20:11:37 +0000 (UTC)
Message-ID: <f98c7555-50ba-d505-b3bf-c3c8c5b2d290@schaufler-ca.com>
Date:   Fri, 10 Jun 2022 13:11:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] smack: Remove the redundant lsm_inode_alloc
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220610092307.30311-1-xiujianfeng@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220610092307.30311-1-xiujianfeng@huawei.com>
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

On 6/10/2022 2:23 AM, Xiu Jianfeng wrote:
> It's not possible for inode->i_security to be NULL here because every
> inode will call inode_init_always and then lsm_inode_alloc to alloc
> memory for inode->security, this is what LSM infrastructure management
> do, so remove this redundant code.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

I've taken this for smack-next. Thank you.

> ---
>   security/smack/smack_lsm.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 6207762dbdb1..001831458fa2 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -766,13 +766,6 @@ static int smack_set_mnt_opts(struct super_block *sb,
>   	if (sp->smk_flags & SMK_SB_INITIALIZED)
>   		return 0;
>   
> -	if (inode->i_security == NULL) {
> -		int rc = lsm_inode_alloc(inode);
> -
> -		if (rc)
> -			return rc;
> -	}
> -
>   	if (!smack_privileged(CAP_MAC_ADMIN)) {
>   		/*
>   		 * Unprivileged mounts don't get to specify Smack values.
