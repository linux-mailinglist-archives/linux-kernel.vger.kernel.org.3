Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13A14ECD21
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350623AbiC3TUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350620AbiC3TT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:19:58 -0400
Received: from sonic312-24.consmr.mail.gq1.yahoo.com (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287DC996A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1648667849; bh=bYSTBk56y7nX0vPVoAF05dNkFgg/1tnbzT061YMXM2k=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=KiVoQpVu2IEkIWY9oSArEAr122KpSKVGS15plheJv81DPFskuFZKxWaoEi+FtaoJ+dAyxYsP/3PDj/LOaOEFFjeOkV8utOi87ncgziib7MUKuqL5RZ3AHj8retdb3EG6b78EWgKQcJCqbzUunNYYfoVt9CR/qNL1nMpY2AXjPSwmimzLCiTne0cQN/gS5NwfhbH67+nO7MARxldKHRodknK4bvXqBFGKvXn5uBtp65e8XZllSh5MIpOR1gRk5iUAICROFiFWYroC5o1oJk04uhEe4o72eRomNfhebMiq8w6e5UnM1t4pLvPM/NJYGwEQ/OwqEme9/eO3dWzr7hAC9Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648667849; bh=CW4yvdMcDnpz5h3u9cEx7UJb0s5+z1PvRcQjRkXueoE=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=kQF0CLAUunmIIT950c9pMc23YVDrCqSmTW806cKdOknkTllhBaDjSlrSH31NUjNy9aA6y9iobGC6hN/VWGMQD2I7GMGOtfj0+ktveCkeb437kAE499XJ8wZHBZJ8mXnnvC17si17KxWXWMEUTic5pJKXB37Z4jCVOK7cXRCom2D1r52RiyC7BnsmpLazKDLzCziygwsw7MaEqAIAUOPvs1SEQtX4H/3A5oloi0AoQULKG4RNjUU+gOMLGaoMHbyQYziE8lzOGKK0zoa7ch6kJOUgIYwxCv7NLt2Ws3BQcnqyXRlB5oxGnbGiFy3RtOV0qP7+Zzbq0T1NmuJOBLYRqQ==
X-YMail-OSG: 0NCPYK4VM1lFBMKOvvcDYLXXw.Qhaof2feMD3Myq9EtDhCdUj7.K60QHtpC4d7B
 x75cOI_u3D6ExzowGZ8eIjpCpMD9SawDy792Tlz8ST0hjfG43ks07lvGIc5JGkSh_btHClzl_fyH
 qjnjoVvX5LsrMRfnUO5M5CF.MTC8bXlcS0qFiVoEtROYqZezO87WWjCt4anwawIoTq4vwoes.fsD
 CO9umRicCLdXiw3cuq38WotL0.2_.Q2cy.15pT0lhf.Q5fY6vTN1g3ugh0ESIsyZliPmuHPadAwy
 vUJ51Mkn.2FCbxzrEPQaUzZmvlP2b.pCEG7gm3VFzTODimEIxyU0Am1mquug1ikDFAN9iTLXSE0J
 JshXAD5FapEfr9wuqNSVGO7NK0TnawteGsiuiIaLAlbm4IYk.EEUldUyKzk2mWSKiF7TVhc0QFWK
 Wrc4AoThTe_bR_TIY1pyKj2vhkugGdnCaJtyPchTm063BRjAGjdwpJgI578VFhznLVf0.b6wcvkL
 WEwrI1AJSMCpXEyr98tCQRw3tob94EaE3K.et.grdmP2mk3L1IATg1_oy34ER4Rx8tik5xbtTr8h
 h2P7cflJx9icB5i0ra7ARhNC.RCTnBsqnY3ezMvdGI3vVTWgpNf0uYpRYRZJQ0B7uWE9ybonTdCR
 Eu1kgpjk_CFctly4HspZ0Ktdf9LHhcTgmhI1P482q6WxYii0VqgvmSkeDoKvTO2IjDKi3tcuER7y
 Bju7ZzxFl1DIZ8EN7c1aZY8ZXg2xWM2cvyMn8IF8TPQ0cRojdSQgDAf2i7k4C.m03T2Cm1NQJu5C
 o7vOYLZBqCf2wJ4q.2dts7kXSdJ_CywXkS2wmwNxDN7Hi1A6Rxm9J5GbZ1aUtwKtA2X6RsIsDSQb
 a28m57N_z8_hxhpwWOdEN5ryViipx_SVc4fwvEyYoRF6FfyqQgknz53S08yLpTDdoluTsypuHj8w
 Ih60_st.ZqwLpqszIgCuPGkT8BMDaKCQGE70NoHvMZcmyzeS7G158_lGYySVZNc3xL5fxBjdVBce
 uGauUBnyqxD7B7D_rwfBCnLHTH2NsyWDSctoedShTzFgb_6t11flGRdrdVANisFEeft4YQWAxBh_
 B9XJZ56zfGIyAAx8ncAzRQfyqW2CByq9mIukZ7.JJYnfUJoElG1LMi15.tCNTtCtbiqcQeYCjQ89
 hcJR_eN2qgJPQkJnWklRxM0tAlXXNWT3Ge_tag7Bn2DDjue.tSb1eDG.lVRqJqoEVsjeFsINWEd4
 n49K2iJfa9SeCc9bOyrfbqoSderod46GjeuLvSVuTa76XdA_MqMZq9TR2InbyCLteR24TE.sZiar
 LRKktTjZn_Fp9UtkfLygIj7tm6yaBQv9pnnvhQpOyo4qQbvGVcLDY31UI18GaC6lNVvqJDOwK8ZQ
 ufj3AmoiCM7G6.T6dEZ5OcSuFAu5PXeDelwKfUf1WZ.J4cqOrpr4_N3FJ2gOICSZaW_JB7qqQTPl
 K0V5dqn_qyeVZYHp3b5r8mVa2KZ0jTjcJAj2WD1iTEHRGRDdfwvXzjp4uO9G52ep5BVM_A0AHPW0
 Llwf01KljY2bADb_K1_R8.BRLe1zdW5i5_zBaXy7qW7PxGjy0Y2ADOj_bZjF5hwXMhIql3W2SooU
 oNoXqXa3MkTPsDK3loXTrNNyQPMLbAJlOkr_Fv4sFhpg3U5ANSK7D8idbbPEklX3bQvwvp3rxKY2
 zF4AaJEoPCZKklr6ly.zZ4gbr6Fzwgxe0T48kL4pK45naEDRYepOAqqv1BBb0e1p0Ep.4QfVIXWC
 3ULWyFJlkjDc67Ph_AvGjYYDZ1XzROLPZm2r53kJsQIaJM1i8lOM0Fbz1d_DQKtHj.KiM7n11yyG
 YlQxnRkv54R4EPW5sOLkEbxEKQJNa8LqKA4wwpsZxzYbGsPAi3vv2p4Y9aQJ5HbILqyOqu1HSG_j
 URpspRvbe1.4qGuZW4JcjaRHHiwqLfQTffSTKEUv5YsFtIs9ADQPLBAmLbobZZuZLfnD40fx2kic
 tneor7e9xQ1AdQK07kGln4UPzLVmuDeKuze2ZFKmo29VCAtcaBKwPIDZWeq9mYrPlVtPqhwPdzQE
 eofaqtaREMRmXyQibLxhu9DHJQLRprqp6K6ii3.w1d70oLJXArHtG9be41y_IUfjg_TP6v9kyfDB
 5kLqu.62MJK.M4ywzJqb.UG.41v9aTiiN1Ol0phQGW.rPZ_fu.ASRlDZ6wli8inmEHRuXoMNEyDA
 LJGaKmCX3FcC0f.Fec_EsQIZKOSt7gF_A9OXeNkaidrHHAgscqzIFCyFuNXn5vlp7REuOkGl4qAX
 onb6oHspv
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Mar 2022 19:17:29 +0000
Received: by kubenode506.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 63db5f03f6392474c142bbf9cb253686;
          Wed, 30 Mar 2022 19:17:24 +0000 (UTC)
Date:   Wed, 30 Mar 2022 15:17:20 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD SME boot fail
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <1648659326.eabkokyuym.none.ref@localhost>
        <1648659326.eabkokyuym.none@localhost> <YkSa9d3JOExAiBXU@infradead.org>
In-Reply-To: <YkSa9d3JOExAiBXU@infradead.org>
MIME-Version: 1.0
Message-Id: <1648667469.u35o6clg82.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20001 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christoph Hellwig's message of March 30, 2022 2:01 pm:
> Can you try this patch, which is a bit of a hack?
>=20
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 50d209939c66c..61997c2ee0a17 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -28,7 +28,8 @@ bool force_dma_unencrypted(struct device *dev)
>  	 * device does not support DMA to addresses that include the
>  	 * encryption mask.
>  	 */
> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) &&
> +	    !get_dma_ops(dev)) {
>  		u64 dma_enc_mask =3D DMA_BIT_MASK(__ffs64(sme_me_mask));
>  		u64 dma_dev_mask =3D min_not_zero(dev->coherent_dma_mask,
>  						dev->bus_dma_limit);
>=20

This seems to work for me.

Cheers,
Alex.
