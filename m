Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC0D4BCA36
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbiBSStf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:49:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242082AbiBSStd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:49:33 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6D96E783;
        Sat, 19 Feb 2022 10:49:14 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b9so11325471lfv.7;
        Sat, 19 Feb 2022 10:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7YhVG8Dy+S1k40YAXhEZryTJrbvkmx9GiFs6+GPhuaQ=;
        b=H2eafIb0d+gnPTeQfQp3hdpbyrFDjuxHlgGunCA2MiiBccQeIlixC6yWs5I08xT0nN
         Xdxjxk6Mzk8p+BE7e+dKuSRT5dolF+XjEsJlja7p0ETEvEEvuH8Yh4dlWKRoZ4iZ8OXR
         U2uMxEimT2NduF42uHLQHUyEfjdv17in99/lWPBlj/UL2FNWAnSXBzrBQJDMu+DCgkAH
         rM5Bvsb9e5s2clBjZTXORVVjUxCWI1VNQIWotvuonsawBYM+5GZBhOaAS/1YLepiFidN
         FhhGEihUOKgcKs01grZCKhcxkiknAkYyU1UNow5+2vpKdwOxLKw3yYdKAJcq9QIwFmjy
         ZvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7YhVG8Dy+S1k40YAXhEZryTJrbvkmx9GiFs6+GPhuaQ=;
        b=SOFA9UcPAmDR55npkUyF9ObyBBfv5vFSOolQUApNdwbAcZ+meH7R0bHttk/M9J1X8W
         2TTT3LsawlCjeC1JI6q4kxSZQ00OKvhKqq2xmfna0+YAddQdLoOc+j44JECF3YFXRrJY
         84OkCLjED0yR9TGux5A23IMEVjyHfNOoYhOmbdIBASZYU5gq2zU+7K6f3pLBv2jelijV
         U675+zeyD9AcNc0dG9YRoNOY9C1JWKf6Cn2He5axrX56/j6ChpOAAPDxpJlEzhrZsrki
         5TKV42ZazXOnjgvrPDeZlkelLfMZ3wvkTjDeNbhdPTIgDD4EwGXwJ5wfeldEuJJ0yRQq
         Umug==
X-Gm-Message-State: AOAM530HFqa1hfBcvlKlypV65ReIOtD80QV8A99Mq6d2CT10tysGRkPB
        btdUG4ZI1k0suPSG9GA9OW0=
X-Google-Smtp-Source: ABdhPJxu4c7EAYfGM/Z+Iq7ORPC+Om71HaUK4ew3FTkSHXyN9PFMoo+/wBKUzofOsjvEek347LaSWQ==
X-Received: by 2002:a05:6512:3f91:b0:43e:da3e:464b with SMTP id x17-20020a0565123f9100b0043eda3e464bmr9015660lfa.673.1645296552456;
        Sat, 19 Feb 2022 10:49:12 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id y18sm737447ljd.13.2022.02.19.10.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 10:49:12 -0800 (PST)
Message-ID: <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
Date:   Sat, 19 Feb 2022 21:49:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To:     Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org,
        robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220218113952.3077606-9-mperttunen@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.02.2022 14:39, Mikko Perttunen пишет:
> +static int vic_get_streamid_offset(struct tegra_drm_client *client)
> +{
> +	struct vic *vic = to_vic(client);
> +	int err;
> +
> +	err = vic_load_firmware(vic);

You can't invoke vic_load_firmware() while RPM is suspended. Either
replace this with RPM get/put or do something else.

> +	if (err < 0)
> +		return err;
> +
> +	if (vic->can_use_context)
> +		return 0x30;
> +	else
> +		return -ENOTSUPP;

If (!vic->can_use_context)
	return -ENOTSUPP;

return 0x30;
