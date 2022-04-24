Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F23B50CEAD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiDXCtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiDXCtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:49:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016FB12EB66;
        Sat, 23 Apr 2022 19:46:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 375BB5C00BA;
        Sat, 23 Apr 2022 22:46:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 23 Apr 2022 22:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650768361; x=
        1650854761; bh=8Q+ZFt8iLKfw6+gfcY5JTvb5tFIFfrs8cTxnzQhZJ9s=; b=c
        gybfw8PKzGPaM5ziDhBstmzJgZD9tE6ddGyMu7qOKe2RvB4Cv5bjTUKdCIB/khBN
        jHBUS/MLaiAS1GSlzDdpwmVZ3Mawe/ufGJCJObgoDyCOeXLqfqxAvqj2XHPlSE+B
        K3tSvJkeHXMVj+SKPRPOC8i0nXkcwIsTh1b+bvK49Xw5f9MYd5Fm39lzoccdjwqR
        ZapBY92I9ofh7CsBZ56NabWbWUXPhjV9KeNzDwqit0L0dxM6kosZJ5Z153lpaMoY
        kL+J8puHGexO6qdiz8kXuvqMStl/XOLt2079x46nNfUlqmGP1D8Qlf+CVU3uS+AR
        /pDQ8aRYvSV+KQIFy7UmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650768361; x=1650854761; bh=8Q+ZFt8iLKfw6
        +gfcY5JTvb5tFIFfrs8cTxnzQhZJ9s=; b=pg2o/IZLhelFZ7d1s17VVUHpfzBFU
        +PYgd5T/PxajgWhYPghjoX5VSEDL2aR86SOSQXSbKD2HiZc5IsGtX8ZdD3aAXx5p
        QHvXqrRqG4suPJmkUNsXF2fZHnc7gD7miiJm33Dkm/ip8Id3Y19M7MtY36+2jUgt
        bUPBul5fafOBbIMYEVTcrNJ3htZaez1JP4yXqFs5zZXJ5S9+MSH5K7kUmYMiUiLp
        vG9f9dQSLyH7ZASnK2rwKDgNrAUkEuuxYrVgDeuDyLyuew0x2hOdzkeL+pgg0Pbu
        Q2PHoVOAS1DpSUkSYfnbpASPQ88vvKR8tENPrhl/U1U/BYMq4fjGNHlDA==
X-ME-Sender: <xms:6LlkYnt_RD6hthab-1AVaVwL3kYdw7fedR9k9_EGegDpgh5ymQLE7Q>
    <xme:6LlkYoflDIUy216Iu2Lo3YKrLjzjuITi6DdJnyUsWyIAmD2cXtXj8wtfRMlv65Pdn
    sPuvJr6b93930ItZw>
X-ME-Received: <xmr:6LlkYqxcid5qNP8FoJvkBEADdyE6sjNLrLH18MZfPGmhhlGg2756sz2wqUXN89Up6a8ziF1p18nvwS9fgEZhyiTvmKEgjLUHy2WIi9RwN48Hx6EWXn5NSslAAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:6blkYmNpMgV_CaUcws0HrxLCFwgpgDCVraQIvkEwnAvphAzKhWA6qw>
    <xmx:6blkYn-Vrb5Y3IyXxqO_mlZcqR-uw_auyQVFblYUB787TDC7GYmpNw>
    <xmx:6blkYmVdM5jkbMto-qQgFkd3puQJDEcIIhmMy7A9TRUbn4XsMRgpCA>
    <xmx:6blkYuaokLQhtCUKmeuIT-kjCUlPPqQ49iCmMXaaCR3dAPjqYCIkqA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 22:46:00 -0400 (EDT)
Subject: Re: [PATCH v2] cpufreq:fix memory leak in sun50i_cpufreq_nvmem_probe
To:     Xiaobing Luo <luoxiaobing0926@gmail.com>, tiny.windzz@gmail.com,
        rafael@kernel.org, viresh.kumar@linaro.org, wens@csie.org,
        jernej.skrabec@gmail.com, mripard@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220423151204.2102314-1-luoxiaobing0926@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <4ee2421f-79a8-7f4d-f7ef-33f0ccf49337@sholland.org>
Date:   Sat, 23 Apr 2022 21:46:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220423151204.2102314-1-luoxiaobing0926@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/22 10:12 AM, Xiaobing Luo wrote:
> --------------------------------------------
> unreferenced object 0xffff000010742a00 (size 128):
>   comm "swapper/0", pid 1, jiffies 4294902015 (age 1187.652s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000b4dfebaa>] __kmalloc+0x338/0x474
>     [<00000000d6e716db>] sun50i_cpufreq_nvmem_probe+0xc4/0x36c
>     [<000000007d6082a0>] platform_probe+0x98/0x11c
>     [<00000000c990f549>] really_probe+0x234/0x5a0
>     [<000000002d9fecc6>] __driver_probe_device+0x194/0x224
>     [<00000000cf0b94fa>] driver_probe_device+0x64/0x13c
>     [<00000000f238e4cf>] __device_attach_driver+0xf8/0x180
>     [<000000006720e418>] bus_for_each_drv+0xf8/0x160
>     [<00000000df4f14f6>] __device_attach+0x174/0x29c
>     [<00000000782002fb>] device_initial_probe+0x20/0x30
>     [<00000000c2681b06>] bus_probe_device+0xfc/0x110
>     [<00000000964cf3bd>] device_add+0x5f0/0xcd0
>     [<000000004b9264e3>] platform_device_add+0x198/0x390
>     [<00000000fa82a9d0>] platform_device_register_full+0x178/0x210
>     [<000000009a5daf13>] sun50i_cpufreq_init+0xf8/0x168
>     [<000000000377cc7c>] do_one_initcall+0xe4/0x570
> --------------------------------------------
> 
> if sun50i_cpufreq_get_efuse failed, then opp_tables leak.
> Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")
> 
> Signed-off-by: Xiaobing Luo <luoxiaobing0926@gmail.com>

Two minor style issues: there should be a space after "cpufreq:" in the commit
subject. And the blank line should come before the "Fixes:" tag, not after.
Otherwise:

Reviewed-by: Samuel Holland <samuel@sholland.org>

> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 2deed8d8773f..75e1bf3a08f7 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -98,8 +98,10 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	ret = sun50i_cpufreq_get_efuse(&speed);
> -	if (ret)
> +	if (ret) {
> +		kfree(opp_tables);
>  		return ret;
> +	}
>  
>  	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
>  
> 

