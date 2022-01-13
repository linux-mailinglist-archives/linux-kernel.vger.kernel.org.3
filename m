Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA48948E02F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbiAMWTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbiAMWTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:19:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0392C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:19:02 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c3so11639968pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VNoaIqYSS5igvnCs4kwaW4XfycxM13KnkSzCOBOjnmE=;
        b=Nuhs5dd0c7HhXpYf6DA5mML5D2RQBfiweW8QrI7E8hh8C6YP//PjwMZYygAErMdz39
         qW23KauwPGQ42r6TOe5hNfTw2XJs6OSdFjm3/dr/Xgy+CVxnIctH2oL62AeQjKdQU4Vi
         vI/XaChlGNla8cPWzyWpMw5u6CaXOFrrGWs00d5Ly0hx8+KkDLlZpUvaf/3gpdv8B0yh
         e013bXI7SOoaHBi+CoiRhn+Fk7KDwd/eb5QzjpOBMwhfjSq9sG8q2vCnun/1SROmqCLV
         D2qn121pqUn0WEMFDRJhNuH0dy7IMeBHbq2I0Sxms0EY4zwipLHDbCb0OicgORPaGaGm
         tssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VNoaIqYSS5igvnCs4kwaW4XfycxM13KnkSzCOBOjnmE=;
        b=dUV2VBNnDueZa6ygDO3ASXoLZjESgOd/PFrEU6Xjkg2erzGwbepZUE33kHgHohA+SJ
         JY4HAu5zmIV/pu1+c4OwU1wz22MaoA5y9rdXxbeJ++YO2Ydei7BOBNXRPgM1FqvvbdhH
         W8C+5zD4oCtjlusO4wcNaiIicOx+73WxzY4oJsM9utVM/W2C4/ua8ltqMj0Vd3GDCHd6
         Al3zkf5WYpDL0DRhLVxh37dmxNI5stsRzHN0LmHAdYKLjTBXh8AABQDN36ax2oR+TOhH
         aLTXh+lXdpoWyaY4JK4EuT+YtFQnRfdJfE4YM1+ruv0WUUleeMqhJCffelPpAzi4mVpz
         feHw==
X-Gm-Message-State: AOAM531t86g3YamzupvHRs7u9eplA23i1YNowEKjzqFd55YpxueCtH5y
        iMCwq5eC9tUA1TUrv61VUkQrgA==
X-Google-Smtp-Source: ABdhPJzkdSrI9bPQqYfFlXq81svJ5+IiAGMGDR301K93K/UkeXCphJAYmh7WEKztCPJm7OSl114X2A==
X-Received: by 2002:a17:902:e34b:b0:14a:4b9e:a0f2 with SMTP id p11-20020a170902e34b00b0014a4b9ea0f2mr6487070plc.91.1642112342117;
        Thu, 13 Jan 2022 14:19:02 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id 65sm3533239pfw.70.2022.01.13.14.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 14:19:01 -0800 (PST)
Date:   Fri, 14 Jan 2022 11:18:58 +1300
From:   Daniel Beer <daniel.beer@igorinstitute.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Liu <andy-liu@ti.com>, Mark Brown <broonie@kernel.org>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>
Subject: Re: [PATCH v2 1/2] ASoC: add support for TAS5805M digital amplifier
Message-ID: <20220113221858.GA18380@nyquist.nev>
References: <cover.1642063121.git.daniel.beer@igorinstitute.com>
 <a2e4461ee2d2a052984f447f9891f8b4ecc9307c.1642063121.git.daniel.beer@igorinstitute.com>
 <703cec53-5de7-e8c1-5a1f-e44f0cbc141f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <703cec53-5de7-e8c1-5a1f-e44f0cbc141f@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:18:27AM +0100, Amadeusz Sławiński wrote:
> > +static int tas5805m_vol_put(struct snd_kcontrol *kcontrol,
> > +			    struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *component =
> > +		snd_soc_kcontrol_component(kcontrol);
> > +	struct tas5805m_priv *tas5805m =
> > +		snd_soc_component_get_drvdata(component);
> > +
> > +	if (!(volume_is_valid(ucontrol->value.integer.value[0]) &&
> > +	      volume_is_valid(ucontrol->value.integer.value[1])))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&tas5805m->lock);
> > +	tas5805m->vol[0] = ucontrol->value.integer.value[0];
> > +	tas5805m->vol[1] = ucontrol->value.integer.value[1];
> > +	dev_dbg(component->dev, "set vol=%d/%d (is_powered=%d)\n",
> > +		tas5805m->vol[0], tas5805m->vol[1], tas5805m->is_powered);
> > +	if (tas5805m->is_powered)
> > +		tas5805m_refresh_unlocked(component);
> > +	mutex_unlock(&tas5805m->lock);
> > +
> > +	return 0;
> > +}
> > +
> 
> put method should return '1' if value changed, so ALSA knows to inform
> userspace utilities about change. You can check if userspace is notified of
> changes with "alsactl monitor", you should see something like:
> node hw:2, #3 (2,0,0,ADC0 Capture Volume,0) VALUE
> when value changes.

Thanks, will fix this.

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
