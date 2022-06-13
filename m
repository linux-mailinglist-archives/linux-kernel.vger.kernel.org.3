Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEA1549B97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbiFMSed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245179AbiFMSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:34:06 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E04C9651
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655132021; bh=0SgoT7OQEOKIkib3oIGruLdZdvQGYAiUQ4MXiAUTnPI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FXke69JqlRRNJrFFWvEOaPCujhPRK221IP9c3YDlGwPEBRdFzJZzFtjHPUmW1k4q+b7iMdili2lrpgJj+l4qie8Wkqyb1eP36fWrIdUAQb51SG+unKpw/p30eIEJoDi3uoSan+LUESE7hNGLwJLoEWNjwKyYq54CMvxYa9nfrX4mBujcERvRSlnPDXDko0Q5vVyUe/p92IDzW4sZ3cMivBx6DWqKFsCG2jILkSBO7N5BPHm2VgZTriYrOPOrK9tLghcWARHBIQkGtOMgRXi7SUm3zHAXKpD/5QUGtjVsnKpcX//uqeQUughn6WMR+OJmNQtwC/dmiCeIomrKh/k+Jw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655132021; bh=grY/OEdyoXdDjlfXN0/WNt7lg26XYsq3xUM46loWHYq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TXf93jjHQtF0SYfWaqpCmU+mfcET2+RuDUTrRJwdRV9TCx1YMk2pcbcK/y2ZbO0Z6+23EBR5NzHIMTZVqXB7AJQabf1dCGzkRc6EoFxsIjz5J7sfhb1o/4lEkP0Og9UQR5MaljnZHylHgN+qVlpW5ADFIbSDfGeEkbP/vMx1F2W+HQAmzZnQltqmPJXgG57ONDL18qZptZ3UVUkHYEBDO3q+78jnhqrCi2cWlUnEfWNO/JQAAfyP5YEB+yn/MFQAHBxvbimq6r1fr7h+vGss4sA5gIbLfKH6RAPsNKACkaslNMzobmTDV6bhq2CUiwgbKN41K+H3fb/lJoAQJt/4Nw==
X-YMail-OSG: CBD8m6sVM1mWWJAJktVvFXOdXPIh01AqOykUKU6tjLybFlu0MbXn8siUQnJPdK5
 pJkRlW9z8kTyajt73IQ.H9kO7TFfFYeVEWc2CagvVFNTngALaInQWI_7BRHuHUYAvAJ1M7s1uVah
 lV35hC.5gp95I1TBStohgbUNkUy_NFhTcnAJYXNAVHaKss2REl5Yvj6rlAnJE8pXvjQiU0pZUUIQ
 Mk78gDxnb2GfQy50e86oad1rWJZsAdYrOmXxR3dI8ZFzhDBoZa_gYB_gPPzG0ZPTbXuazxtUDG6Y
 wUgehSGMSm1Ju3QNMQH12EP.SVcFLqACieUK2FVZ3H4oHfvG2NoJRLztiHkKd4c6eUMSWFOahXSL
 .ErMKIAqZh855oc8DIgg3b3inMk2AowuXePypXU42vWt22gzHRP53ntPkCicrafYs_8Uj4wx3H5u
 eWQwtNOewGndsVCwgmAKbH5SEvwo7naOOPjJcNo2M5adkrVC4sGuc2a74.i3kpq9FTm5UflngbNe
 vTcnNTbXglj_iC1h0lyU7cWone4DPYPbvmQYYFGHZHek9jEdRv5CI22YCbkkZDHLodtWowWYt3By
 BHDGmnKow6weKsqErZ9.B7q.P1_rUAB07SExKYF70xhrWR_2d7AuvJM68pdIN3Aihzg8EYpipmJw
 V5hArBMtyzoYiTUJ6Y7otrADachTRw6PEQVlSY8DxRidimBOqPVU1zhQHJDWCerHo7pi4VBhf8I3
 .vyNxj3bKxKOkyk2H.kQILzlWpAhcUeWbx84Iv0jh_XftG01DopPcO2PDVAYd3ZA6uu9oDB_vtUo
 .pVNf1ewC7Jt4THvozxFVTsSuoUKmw3m_zs4XNttcgPu.qUWB5iRSsSirWeCV2OG468GLlwOGpQu
 OdiRffzwLFEcEW6BA7UMhOvsHfhJAS1FpegaRmgvyFNv4SI60odpz7OoKraLjSTPlAv.eapbC9wj
 YTRzA7c2.s3Cn_jexuGsOQX98WeJXRMsy81_b6bycp14iFdQfWVbtxyTktRK59DacI3HVDh50WPq
 d_e113GdPG.CJl6yuZe.YOExvlRj0QtUclZGjXHYaLKMdw_7BRRjkkWqkDUP36f1mzoZMHsAmUjN
 AJR95D1cvkTahP1i16WwqyMwexJ8xtsf2GxDStXkXXWQLm2H5TYBbN8U_kSiXfKKxB7pdGsWUtqQ
 L_93lbD6lKH8HanxeZP2rh0GBThm36V9OlS1EiVNYRMWDBU82wnbSRLclTEsEG_h1ee3.4iDFKb0
 dvbLNStL2mj_U.pBYcv7DmsCmtcXLBr8IimYx2P0cO5Gj.7DYMR6msy1XuvvUTMh4Adt.kBJ7SUN
 1tXfUMlFIYN.nHGY_AQjo4Jhvcfy9BKV9w3HMwkkko4C_YufHcAFte6AyC4OXwkopn6JZQqN13va
 0dEe35j9xsJ6nsqHDWgIla34.HThBHx8s8zEguHdtIz7kVYe4vo3_esmvCE3yXFJaBzaRWVyFcIZ
 vVWa_otkQ2abgjV.XqHNVbz5Cpx6WUjRmSD2jppojRdaqIvSvoJtAs19GTeKa6mHcG_pQCcy98pi
 eWBth_xHQyKOSdSWIilg6kPO8lKRO0YYbiDwRvMGThH4zetoMlj4rHKqDOcGIaOLfyLVV1gZ7A4I
 ue_gPyCT7M9wqRwSApoV3T6U3zEDHkyGdrx1bFJGTGxNknnrDx9.4hScHWHbhhxli1xZMCob_ZIb
 vYEzAkFZWwtiXTDeWWtEv3S83I40YeRyvLiHED3x9RsyvV9vtNnGReMTf.woXnQ9qnIALAa25PgL
 cGGNkea1Zuy3O02n7o6EmQNwSS5g4QPdh7Hlw2vRe3BcscZHQ.hcGDru_z3YzMp2AA6HUnIZaYen
 9Yi9CdpnmO5y.C3uVVAJ2JLGqBo90MRgJjmBzj1nLG1eFnhNJuhcYdJ35tBvBt1ApOCeEY_Op8UV
 DDdhsfeZIaB39pj785P7krEy_pxh5PRkw93.YFtec8j96XtjW1Hg0bWiGt0iW5GvnhIgnpVd8xp.
 VGYyaM7g9pBG4zQW9KlE3NAvn5JPtDzg1_FjtRtx.VSRsLkct2jJ5P8im49_.P80d1NWjcek7ggy
 _3RNuPGuGUmuxKLi3RrYEGuS9x_oyWytgHLmOGuNAF_G5hIZBJjgaLy.D3h72mWVS6qCQLRlJ0yG
 bozTQwZrsaTYPCpgf0gU1Fbh3bcIfDtUe_7ZAY6SExM.4zT.6IjKHnAYhwbXS.77lkpJCK3ucN9c
 fYp1YbIxb7gK8n0v4e3c4wYExBTspHn7OFyJh_c_cU2I1kTu_hJEwmZb.apIj4xJUI3T5mfTjZsX
 0Ppt.lSaHZ5Q7S.T4KzL.TWzrSWZiRvk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Jun 2022 14:53:41 +0000
Received: by hermes--canary-production-bf1-856dbf94db-lkxdg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1de6620996886a81d03d658fd9893895;
          Mon, 13 Jun 2022 14:53:39 +0000 (UTC)
Message-ID: <88718d10-4435-f5a8-9123-afc73257e0ca@schaufler-ca.com>
Date:   Mon, 13 Jun 2022 07:53:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] smackfs: check for allocation failure of kmalloc()
Content-Language: en-US
To:     Li Qiong <liqiong@nfschina.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20220613062202.29194-1-liqiong@nfschina.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220613062202.29194-1-liqiong@nfschina.com>
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

On 6/12/2022 11:22 PM, Li Qiong wrote:
> As the possible failure of the kmalloc(), it should be better
> to check it and print a warning message.

The allocation is done with __GFP_NOFAIL, which assures
it will not fail.

>
> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> ---
>   security/smack/smackfs.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 4b58526450d4..0d11ba3cb4cd 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -695,6 +695,11 @@ static void smk_cipso_doi(void)
>   		       __func__, __LINE__, rc);
>   
>   	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL | __GFP_NOFAIL);
> +	if (unlikely(!doip)) {
> +		printk(KERN_WARNING "%s:%d failed to allocate a memory for doip\n",
> +		       __func__, __LINE__);
> +		return;
> +	}
>   	doip->map.std = NULL;
>   	doip->doi = smk_cipso_doi_value;
>   	doip->type = CIPSO_V4_MAP_PASS;
