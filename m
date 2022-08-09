Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2912F58D5A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbiHIIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbiHIIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:47:29 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E80222AA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:47:27 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y23so12269512ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kf6RB9jok9vmUEDQMxifjNMK7BLit3Am1wUqMH37r7c=;
        b=NZUoQnM5GYNbkoCkxgUPIvjJWvpSp6sR18qseY7O6LYCUtWPxJWrwgwqaGmyOC9/FC
         /ojoObcnsCD4fsjN56neYdslxNZOOZTAz0jgYn7TYMAjNEw/gmY0LCKaQ14yg/1SOEx2
         +NpmP5kVTs7jD3LAlAb6my+7ViZPgV+WADQYMVSH/s/ylTazNgqmna4oasrUgfrHjcM4
         sJawTf00tsw7HbpGXeUOXEt2FgJZ+LOA0QicudCVFCZOuvltLhtNSb1Uk0Sm6m6DgMjb
         5DV3t/JLLoe1+004JpVXHEcCssoBW/sfG4JMNB9k1GQsbIFSKf5SpaWXUx4jWI3xzlM8
         lj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kf6RB9jok9vmUEDQMxifjNMK7BLit3Am1wUqMH37r7c=;
        b=q9MGT2zk8oszkPZFPoMSZQ2xMBqKsZANy4zTBT9W2EbEIIqFw4kIPmCF5KRN+uv0kP
         G+9DhiCZiYrj+pp7uGC2KZzGgXkU52OSnFdcNqUzE1h3zu5KvmdnY13gY6Ys2vzNJVCq
         tYG5ZLLlOdoEMzgVQ1OJ3uEJzjKRKGx79Znc11rzEP8eEBwo7qw8o4wN5ZbHrlVpVZ+W
         z3DCG45TGmfc2EymzN17odkzPaJ6sEFaXjKZVuFzvbhEndyXFzUp2/cHFSdv0XB+Lh4u
         EoypocXBR32y1arVvpjefBAgqrL7RyYbwf3SVrfUKM2bDUmNe/9ego4LLIO56bkTImio
         bmEw==
X-Gm-Message-State: ACgBeo3ahtUbhE9JQ1v6wDoSReCscpkmKcscWAtvvpXRLBoBxmB7SVKu
        5SbXlt6nmpKlOXkPKhHCF4rQfQ==
X-Google-Smtp-Source: AA6agR4+C/j35k2Z1sb/LNtJWwX5x65JN+5bijU6cMW1CYhDtANLoVlRhqDnmkhpGCdWwZ8B8Id27A==
X-Received: by 2002:a2e:97d9:0:b0:25e:52ca:a6d1 with SMTP id m25-20020a2e97d9000000b0025e52caa6d1mr6622832ljj.340.1660034846150;
        Tue, 09 Aug 2022 01:47:26 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id x8-20020a056512078800b0048af397c827sm1678258lfr.218.2022.08.09.01.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 01:47:25 -0700 (PDT)
Message-ID: <53c8f062-a760-c65f-479e-53e7991b3f66@linaro.org>
Date:   Tue, 9 Aug 2022 11:47:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] ASoC: apple: mca: Start new platform driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220808224153.3634-1-povik+lin@cutebit.org>
 <20220808224153.3634-3-povik+lin@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808224153.3634-3-povik+lin@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 01:41, Martin Povišer wrote:
> Add ASoC platform driver for the MCA peripheral found on Apple M1 and
> other chips.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>


> +static int apple_mca_probe(struct platform_device *pdev)
> +{
> +	struct mca_data *mca;
> +	struct mca_cluster *clusters;
> +	struct snd_soc_dai_driver *dai_drivers;
> +	struct resource *res;
> +	void __iomem *base;
> +	int nclusters;
> +	int ret, i;
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	if (resource_size(res) < CLUSTER_STRIDE)
> +		return -EINVAL;
> +	nclusters = (resource_size(res) - CLUSTER_STRIDE) / CLUSTER_STRIDE + 1;
> +
> +	mca = devm_kzalloc(&pdev->dev, struct_size(mca, clusters, nclusters),
> +			   GFP_KERNEL);
> +	if (!mca)
> +		return -ENOMEM;
> +	mca->dev = &pdev->dev;
> +	mca->nclusters = nclusters;
> +	platform_set_drvdata(pdev, mca);
> +	clusters = mca->clusters;
> +
> +	mca->switch_base =
> +		devm_platform_ioremap_resource_byname(pdev, "switch");
> +	if (IS_ERR(mca->switch_base))
> +		return PTR_ERR(mca->switch_base);

How does it work exactly? There is no such property... Can you submit
also DTS using the bindings so we can validate they are real/correct?

> +
> +	mca->rstc = devm_reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(mca->rstc)) {
> +		dev_dbg(&pdev->dev, "couldn't obtain reset control: %pe\n", mca->rstc);
> +		mca->rstc = NULL;
> +	}

Similar question.

> +
> +	dai_drivers = devm_kzalloc(
> +		&pdev->dev, sizeof(*dai_drivers) * 2 * nclusters, GFP_KERNEL);
> +	if (!dai_drivers)
> +		return -ENOMEM;
> +
> +	mca->pd_dev = dev_pm_domain_attach_by_id(&pdev->dev, 0);
> +	if (IS_ERR(mca->pd_dev))
> +		return -EINVAL;
> +
> +	mca->pd_link = device_link_add(&pdev->dev, mca->pd_dev,
> +				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
> +					       DL_FLAG_RPM_ACTIVE);
> +	if (!mca->pd_link) {
> +		ret = -EINVAL;
> +		/* Prevent an unbalanced reset assert */
> +		mca->rstc = NULL;
> +		goto err_release;
> +	}
> +
> +	reset_control_deassert(mca->rstc);
> +
> +	for (i = 0; i < nclusters; i++) {
> +		struct mca_cluster *cl = &clusters[i];
> +		struct snd_soc_dai_driver *fe =
> +			&dai_drivers[mca->nclusters + i];
> +		struct snd_soc_dai_driver *be = &dai_drivers[i];
> +		int stream;
> +
> +		cl->host = mca;
> +		cl->no = i;
> +		cl->base = base + CLUSTER_STRIDE * i;
> +		cl->port_driver = -1;
> +		cl->clk_parent = of_clk_get(pdev->dev.of_node, i);
> +		if (IS_ERR(cl->clk_parent)) {
> +			dev_err(&pdev->dev, "unable to obtain clock %d: %ld\n",
> +				i, PTR_ERR(cl->clk_parent));
> +			ret = PTR_ERR(cl->clk_parent);
> +			goto err_release;
> +		}
> +		cl->pd_dev = dev_pm_domain_attach_by_id(&pdev->dev, i + 1);
> +		if (IS_ERR(cl->pd_dev)) {
> +			dev_err(&pdev->dev,
> +				"unable to obtain cluster %d PD: %ld\n", i,
> +				PTR_ERR(cl->pd_dev));
> +			ret = PTR_ERR(cl->pd_dev);
> +			goto err_release;
> +		}
> +
> +		for_each_pcm_streams(stream) {
> +			struct dma_chan *chan;
> +			bool is_tx = (stream == SNDRV_PCM_STREAM_PLAYBACK);
> +#ifndef USE_RXB_FOR_CAPTURE
> +			char *name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +						    is_tx ? "tx%da" : "rx%da",
> +						    i);
> +#else
> +			char *name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +						    is_tx ? "tx%da" : "rx%db",
> +						    i);
> +#endif
> +
> +			chan = of_dma_request_slave_channel(pdev->dev.of_node,
> +							    name);
> +			if (IS_ERR(chan)) {
> +				if (PTR_ERR(chan) != -EPROBE_DEFER)
> +					dev_err(&pdev->dev,
> +						"no %s DMA channel: %ld\n",
> +						name, PTR_ERR(chan));
> +
> +				ret = PTR_ERR(chan);
> +				goto err_release;
> +			}
> +
> +			cl->dma_chans[stream] = chan;
> +		}
> +
> +		fe->id = i;
> +		fe->name =
> +			devm_kasprintf(&pdev->dev, GFP_KERNEL, "mca-pcm-%d", i);
> +		if (!fe->name) {
> +			ret = -ENOMEM;
> +			goto err_release;
> +		}
> +		fe->ops = &mca_fe_ops;
> +		fe->playback.channels_min = 1;
> +		fe->playback.channels_max = 32;
> +		fe->playback.rates = SNDRV_PCM_RATE_8000_192000;
> +		fe->playback.formats = APPLE_MCA_FMTBITS;
> +		fe->capture.channels_min = 1;
> +		fe->capture.channels_max = 32;
> +		fe->capture.rates = SNDRV_PCM_RATE_8000_192000;
> +		fe->capture.formats = APPLE_MCA_FMTBITS;
> +		fe->symmetric_rate = 1;
> +
> +		fe->playback.stream_name =
> +			devm_kasprintf(&pdev->dev, GFP_KERNEL, "PCM%d TX", i);
> +		fe->capture.stream_name =
> +			devm_kasprintf(&pdev->dev, GFP_KERNEL, "PCM%d RX", i);
> +
> +		if (!fe->playback.stream_name || !fe->capture.stream_name) {
> +			ret = -ENOMEM;
> +			goto err_release;
> +		}
> +
> +		be->id = i + nclusters;
> +		be->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "mca-i2s-%d", i);
> +		if (!be->name) {
> +			ret = -ENOMEM;
> +			goto err_release;
> +		}
> +		be->ops = &mca_be_ops;
> +		be->playback.channels_min = 1;
> +		be->playback.channels_max = 32;
> +		be->playback.rates = SNDRV_PCM_RATE_8000_192000;
> +		be->playback.formats = APPLE_MCA_FMTBITS;
> +		be->capture.channels_min = 1;
> +		be->capture.channels_max = 32;
> +		be->capture.rates = SNDRV_PCM_RATE_8000_192000;
> +		be->capture.formats = APPLE_MCA_FMTBITS;
> +
> +		be->playback.stream_name =
> +			devm_kasprintf(&pdev->dev, GFP_KERNEL, "I2S%d TX", i);
> +		be->capture.stream_name =
> +			devm_kasprintf(&pdev->dev, GFP_KERNEL, "I2S%d RX", i);
> +		if (!be->playback.stream_name || !be->capture.stream_name) {
> +			ret = -ENOMEM;
> +			goto err_release;
> +		}
> +	}
> +
> +	ret = devm_snd_soc_register_component(&pdev->dev, &mca_component,
> +					      dai_drivers, nclusters * 2);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to register ASoC component: %d\n",
> +			ret);
> +		goto err_release;
> +	}
> +
> +	return 0;
> +
> +err_release:
> +	apple_mca_release(mca);
> +	return ret;
> +}
> +
> +static int apple_mca_remove(struct platform_device *pdev)
> +{
> +	struct mca_data *mca = platform_get_drvdata(pdev);
> +
> +	apple_mca_release(mca);
> +	return 0;
> +}
> +
> +static const struct of_device_id apple_mca_of_match[] = {
> +	{ .compatible = "apple,mca", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, apple_mca_of_match);
> +
> +static struct platform_driver apple_mca_driver = {
> +	.driver = {
> +		.name = "apple-mca",
> +		.owner = THIS_MODULE,

No need for this. Run coccinelle.


Best regards,
Krzysztof
