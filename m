Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135EC4B50BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353549AbiBNMys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:54:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiBNMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:54:47 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA3B9FF2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644843277;
        bh=/INngvtpDk4+hVpxelv8+QybeQFB3fH4rs+P9VeEM9M=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=nhMVruSlyEW3wYRABGU2t7dG4F82yQ6GKVT9c0Y4VkgtY2LyhxqkwF9JxpgZZGJzP
         Ql3Vusn650nJXPuw0D3npX+JJbIL6Af3I5GsyWr/LgHUBvEbzuMq7WY+E45Y7mMSMi
         w2+BASh0q2yCy2J+/NaFIwyxGhp3VA47pYY3f4/k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from schienar ([128.141.229.125]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFs1z-1nVRv13q6J-00H83y; Mon, 14
 Feb 2022 13:54:37 +0100
Date:   Mon, 14 Feb 2022 13:54:35 +0100
From:   Julian Wollrath <jwollrath@web.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: v5.17.0-rc3: Regression bisecting failing suspend to disk:
 ALSA: hda: realtek: Fix race at concurrent COEF updates
Message-ID: <20220214135435.47cff518@schienar>
In-Reply-To: <s5ho839fwfm.wl-tiwai@suse.de>
References: <20220214132838.4db10fca@schienar>
        <s5ho839fwfm.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wzhvPK8bHmJhVrBMm3Eo91URoBxFY/pww+uIZ9foLMlEzb2f1ug
 GV1B5gg1HrZrddCjGZbz5HSVlJ6ATRK74o/LTswu7akoDddba/pg9nFnfCOnWQGTUs04H5e
 aKDCIhjHks1hCQyojProD0VSCd/mrePH0wzLGeNp8KUj1G4dXrbYEj9BKPaak+1DnzZUyN/
 1ZnZXYzsSQJeMiR3kH9Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cAx6LYdP+jo=:USA3A5ITINdYgV7NaPCxE1
 k6amxKApZmneOMx+LqS8B3H98v7+bX7bOpE6DZjINKkORXEc8OgDbi+H1h6I0cEcFIkcdiZjb
 Z9EGV3d/Vx3ks0UhU7xVAg8WZzLI0t84TYCuc4NrlhZJ0KJTh9jHPbvzV7C8+eP1jdfu4QT9o
 efiygcs0tA6L0vi1RfA/5jQtX+DLUTYup+kmn5F4Pi9pVv7PbhVPD0MdMLV6ESc3USPRFV1gU
 ibV8qByUeJYttndxDzWWBKS2xa/C//x5YCZEfBSMX8oJLEMcy0Ly8v3BJSp/WKtTNopvXWv9Q
 J9ki4Z+ksr6bE7egrBDpuDeyKz+F9ubMkeGQ+7H1Ozf3en94vDwFg4yzvv/s+zBvjgzHiCrAi
 2jKbpIItUbIKtQ2StuvxIi3Q8jTFVHj4EM9L1V0fpMq4OhRSNXg1hm1IjXbja51+Xv5ZiQlJe
 2k0g1J1Yvwi70bIM7gzAbWFtxAXajmEmf5SVWGaJCNpYiw5xZ48mh544OBXJD1jjUtUQ2icAd
 PHmysIDma3Z5O8IZEmPF4HTSfYrvp2aaSHSRPtxLAc557Mz3944oHyqJYWQLkjOB7CDBUrI9v
 i9kGCqPUjfQ+qrsm2e1twj3ma4H4Rmp9LIgEzxeaRXzw50255pFyc9skZ56wmZ4exbH4yTGc8
 uKCnnu+f9PZKtG+YvXxflZezmNfHPpq3WkOX+JgdxXZmWmPtMj/gjN4gjWc5recUCTTOfPZ4+
 VoGslIooBfDq6YOBYZrrOQQZLNml7SuZom/4OZlzvXg/O1EoWq8iZEWaLt5r5omtolrW+t0RJ
 8p8mvYDVLUOPMFkdiITY5mH5vRd/8SQuyAq6mNGm0LReLzkmiZglfsafBGG5J8EyPDW0cEBst
 xDCDOcBqJmV6PmkJOpmrFXiOF2nquG5PRpeDBoTCnKRQan85S4vPTiAgMexP4U89XP47wlGK9
 08RyQHWrlfNCRK9ILj8NLI3yXVceI9z+I+WejuQBL63horFwRjLAv1caw//ouJDYEsCBX3Pjy
 9+w5GZTizLwDtNkDlNbL/Ot2X8I87H8p2hGxONAzxHewvBtYCoDNxTpHZsRfrbJXPcg6i/154
 jglXeQcju3GBAE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Takashi,

> Does the patch below help?

yes, that patch does the trick and removes the problem.


Thank you!

Julian

>
>
> thanks,
>
> Takashi
>
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -138,6 +138,22 @@ struct alc_spec {
>   * COEF access helper functions
>   */
>
> +static void coef_mutex_lock(struct hda_codec *codec)
> +{
> +	struct alc_spec *spec =3D codec->spec;
> +
> +	snd_hda_power_up_pm(codec);
> +	mutex_lock(&spec->coef_mutex);
> +}
> +
> +static void coef_mutex_unlock(struct hda_codec *codec)
> +{
> +	struct alc_spec *spec =3D codec->spec;
> +
> +	mutex_unlock(&spec->coef_mutex);
> +	snd_hda_power_down_pm(codec);
> +}
> +
>  static int __alc_read_coefex_idx(struct hda_codec *codec, hda_nid_t
> nid, unsigned int coef_idx)
>  {
> @@ -151,12 +167,11 @@ static int __alc_read_coefex_idx(struct
> hda_codec *codec, hda_nid_t nid, static int
> alc_read_coefex_idx(struct hda_codec *codec, hda_nid_t nid, unsigned
> int coef_idx) {
> -	struct alc_spec *spec =3D codec->spec;
>  	unsigned int val;
>
> -	mutex_lock(&spec->coef_mutex);
> +	coef_mutex_lock(codec);
>  	val =3D __alc_read_coefex_idx(codec, nid, coef_idx);
> -	mutex_unlock(&spec->coef_mutex);
> +	coef_mutex_unlock(codec);
>  	return val;
>  }
>
> @@ -173,11 +188,9 @@ static void __alc_write_coefex_idx(struct
> hda_codec *codec, hda_nid_t nid, static void
> alc_write_coefex_idx(struct hda_codec *codec, hda_nid_t nid, unsigned
> int coef_idx, unsigned int coef_val) {
> -	struct alc_spec *spec =3D codec->spec;
> -
> -	mutex_lock(&spec->coef_mutex);
> +	coef_mutex_lock(codec);
>  	__alc_write_coefex_idx(codec, nid, coef_idx, coef_val);
> -	mutex_unlock(&spec->coef_mutex);
> +	coef_mutex_unlock(codec);
>  }
>
>  #define alc_write_coef_idx(codec, coef_idx, coef_val) \
> @@ -198,11 +211,9 @@ static void alc_update_coefex_idx(struct
> hda_codec *codec, hda_nid_t nid, unsigned int coef_idx, unsigned int
> mask, unsigned int bits_set)
>  {
> -	struct alc_spec *spec =3D codec->spec;
> -
> -	mutex_lock(&spec->coef_mutex);
> +	coef_mutex_lock(codec);
>  	__alc_update_coefex_idx(codec, nid, coef_idx, mask,
> bits_set);
> -	mutex_unlock(&spec->coef_mutex);
> +	coef_mutex_unlock(codec);
>  }
>
>  #define alc_update_coef_idx(codec, coef_idx, mask, bits_set)	\
> @@ -235,9 +246,7 @@ struct coef_fw {
>  static void alc_process_coef_fw(struct hda_codec *codec,
>  				const struct coef_fw *fw)
>  {
> -	struct alc_spec *spec =3D codec->spec;
> -
> -	mutex_lock(&spec->coef_mutex);
> +	coef_mutex_lock(codec);
>  	for (; fw->nid; fw++) {
>  		if (fw->mask =3D=3D (unsigned short)-1)
>  			__alc_write_coefex_idx(codec, fw->nid,
> fw->idx, fw->val); @@ -245,7 +254,7 @@ static void
> alc_process_coef_fw(struct hda_codec *codec,
> __alc_update_coefex_idx(codec, fw->nid, fw->idx, fw->mask, fw->val);
>  	}
> -	mutex_unlock(&spec->coef_mutex);
> +	coef_mutex_unlock(codec);
>  }
>
>  /*



=2D-
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments
