Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A86147667C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhLOX0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:26:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhLOX0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639610797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SsAx99MeaCFM1az6RHVLNIfY4G8x+yP63a3P4Zzu+lU=;
        b=S3actdUS8Ow/FcB6zWWVTSfzC+VZSgIQBw2suxPa/MGCCp8VUTDRY2g+UAMGDSNPyRrc6n
        97Hiw/kWh/Sx0A+durKle+oE/WcCmt4WPckUANO9IUwlsPzrh43PTz8LlS8NLuRfU2qjmJ
        J8dYeIsH538ZmMZU1Sd+NKhKQv3l6xM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-jMWsEHh-ODaMV0fn6NlpwA-1; Wed, 15 Dec 2021 18:26:35 -0500
X-MC-Unique: jMWsEHh-ODaMV0fn6NlpwA-1
Received: by mail-wr1-f70.google.com with SMTP id h7-20020adfaa87000000b001885269a937so6328782wrc.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SsAx99MeaCFM1az6RHVLNIfY4G8x+yP63a3P4Zzu+lU=;
        b=SePLNADMV3fH3ZywMseqxD2OoZaongyjsDBFIIXG74SHRrv4Ruf+QRi/m/ApXEiDEy
         rk7hrzF4ioli4LB2Sl4prQtbkmClZTrcwPJo3UUZqNYl9Z3rN73APBK2+UxKpOUYl1bV
         AagEZcgPkA2WfRBquIZfvGDpBppv9Et0xiwhkPhV36yMbjPZDwNm2JBg9UD7+69Qjf9B
         pPyQNu5Q9CzcIeW3ps/73JwM8dETNvxLc++kq1sV9KLtakrcR53K3zGhA4VjtYhvU51s
         am4b0UJwmBFWhP52NL3IZmrSlaynuz+yZuo4GZ6K5oN5/9Bx3eYPCse450J6Xe5uuLeb
         Sgcw==
X-Gm-Message-State: AOAM531tDt543tBhzRcNSv30yqYl7UeReZ8hf7K3+rYe3XQIorUQKq3m
        2bmHhm6It1uFlSsXHY6RudHNU/BRuyRwMYJhxOxNqwbW/cDw+U02uZ3g01X8rNNeR4sB1KDwU2x
        MgmJn71/3HjjPz9hqVjAcN0DV
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr2363587wml.42.1639610794841;
        Wed, 15 Dec 2021 15:26:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEPoD4oVJP3Ziefs+Kl2NTY81tbWeZXa79ktezfNz0WgZklzcSh0s2BFCokXZ2KvRA30dcmg==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr2363552wml.42.1639610794577;
        Wed, 15 Dec 2021 15:26:34 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l6sm3474635wmg.3.2021.12.15.15.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 15:26:34 -0800 (PST)
Message-ID: <e07e7bba-0c2a-c6d2-e060-964ab3592d07@redhat.com>
Date:   Thu, 16 Dec 2021 00:26:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/60] drm: Make all drivers to honour the nomodeset
 parameter
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Emma Anholt <emma@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, Marek Vasut <marex@denx.de>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Qiang Yu <yuq825@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Lechner <david@lechnology.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Alison Wang <alison.wang@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Erico Nunes <nunes.erico@gmail.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
 <58d00cac-dbf1-9704-3c0b-16fd837a5b6b@suse.de>
 <1c1aeb13-6e90-ed2b-08db-11ceaa8d0de0@redhat.com>
 <be79a619-491b-da9f-9db4-de3919e08fff@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <be79a619-491b-da9f-9db4-de3919e08fff@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 10:10, Thomas Zimmermann wrote:

[snip]

> 
> An extra pointer sounds indeed like over-engineering. If we take ast for 
> example, I'd just do something like this:
> 
>    static ast_pci_register_driver(struct pci_driver *pci)
>    {
> 	if (drm_firmware_drivers_only() && ast_modeset == -1)
> 		return -ENODEV;
> 	if (ast_modeset == 0)
> 		return -ENODEV;
> 
> 	return pci_register_driver(pci);
>    }
> 
>    module_driver(&ast_pci_driver, ast_pci_register_driver,
> 		pci_unregister_driver)
> 
> That removes some of the boiler-plate module code without changing the 
> driver's behavior.
>

Agreed that would be a nice cleanup and could allow to for example get rid
of the following module exit function that's just a wrapper:

static void __exit ast_exit(void)
{
        pci_unregister_driver(&ast_pci_driver);
}

But I think these cleanups are out of scope for this series and could be
done as a follow-up. Since the drm_firmware_drivers_only() check would
be needed in the module init function anyways.
 
> Best regards
> Thomas
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

