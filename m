Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010CE4885B3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 20:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiAHTv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 14:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiAHTvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 14:51:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DD8C06173F;
        Sat,  8 Jan 2022 11:51:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o3so18213979wrh.10;
        Sat, 08 Jan 2022 11:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zsB9fKuxMt2W2xFgbkdKAutGKNFcxp4GGyV5sNm1phU=;
        b=XLmJSrHxaIj4vj8gDS8iLCfKKXCMNDe1ky7t9m08Gclf8HAQV+CdfoPgI6g78mzOw8
         1u/aliaxf1aatb4SedXdQhxWbhK1DSpMNClCA6vyB5MqYS5SOjvOV5HItrl+ZQAVE+fw
         YPYQYOp1kHIqsdjZP/RVEJVEZZa9nm8fZPZdzzRDHVU8ftKaxHYUjb/bDQ6mFayoypNG
         m5SBPX52M7rvv7R1Jd9VtrsRsYJPFFPzjjI9BVEP6/ttnM/D+jKyx/TKH9ZkF9IDCCTJ
         tE8++WZAzkg02jmG3LTF/h8jWvpSIjpmRHslJ72gOTEs0yD4YagaefAyOb5ST2G8umD4
         TAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zsB9fKuxMt2W2xFgbkdKAutGKNFcxp4GGyV5sNm1phU=;
        b=3IiIVs0O4QmqWE/b6pZu9Mw0KO/+VO1Xw78mw9uS/wrHHPHU+XZxiCokX11KWtOE7v
         pqajHSmnNpSjoTidSPif+ogiwwLYXVxKmL2PVtwTj5Mn+olCaQPxb5Ti9dbHZZ9EU6DM
         82QTVt3dc58IhCkEDz8DuRL/pylxAtUMkTxiowq/gygBCL4EGUm2wkzGczZRAT43HEhu
         lKWuqFcCTS/8k6nAe7qJYTpqAmH67GKEWnmFgZfysdggEbgd7N9gLCLqVqMy4uiO3FpI
         P3MA7uLzYlldxAle4GciEMINVbxcYh5wSCIBlffwtoQwlTaNRlgt+ze/QoGqWL+3e9DL
         ky7A==
X-Gm-Message-State: AOAM531nkDu6gzNxdYNsJTcjvjMfuoQ/VuK3o34Yg8SfJEP0FYgTAFl4
        ZZb6LfW/Sr/lRDIqoJ5wmgU=
X-Google-Smtp-Source: ABdhPJziwy6/TGTUg7YKE65waeiEnbKb3QICEdnH/l5ppXuuymCm7ktI3KBAAhc8F7bgfREQ7Z945Q==
X-Received: by 2002:a05:6000:156c:: with SMTP id 12mr60469007wrz.502.1641671483018;
        Sat, 08 Jan 2022 11:51:23 -0800 (PST)
Received: from elementary ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id v13sm2226840wmh.45.2022.01.08.11.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 11:51:22 -0800 (PST)
Date:   Sat, 8 Jan 2022 20:51:20 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        peter.hutterer@who-t.net, roderick.colenbrander@sony.com,
        pali@kernel.org, rydberg@bitmath.org, nick@shmanahar.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: add input_set_property()
Message-ID: <20220108195120.GA14485@elementary>
References: <20211202110807.6783-1-jose.exposito89@gmail.com>
 <20211202110807.6783-2-jose.exposito89@gmail.com>
 <YdPnsiFTc2/7f83z@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdPnsiFTc2/7f83z@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Jan 03, 2022 at 10:22:42PM -0800, Dmitry Torokhov wrote:
> > +/**
> > + * input_set_property - add a property to the device
> > + * @dev: device to add the property to
> > + * @property: type of the property (INPUT_PROP_POINTER, INPUT_PROP_DIRECT...)
> > + *
> > + * In addition to setting up corresponding bit in dev->propbit the function
> > + * might add or remove related capabilities.
> > + */
> > +void input_set_property(struct input_dev *dev, unsigned int property)
> > +{
> > +	switch (property) {
> > +	case INPUT_PROP_POINTER:
> > +	case INPUT_PROP_DIRECT:
> > +	case INPUT_PROP_SEMI_MT:
> > +	case INPUT_PROP_TOPBUTTONPAD:
> > +	case INPUT_PROP_POINTING_STICK:
> > +	case INPUT_PROP_ACCELEROMETER:
> > +		break;
> > +
> > +	case INPUT_PROP_BUTTONPAD:
> > +		input_set_capability(dev, EV_KEY, BTN_LEFT);
> > +		__clear_bit(BTN_RIGHT, dev->keybit);
> > +		__clear_bit(BTN_MIDDLE, dev->keybit);
> 
> I would prefer if we did this when registering input device, not when
> setting this property.

Thanks a lot for pointing me in this direction.

I emailed you v3 [1] implementing the change you suggested and also
including the "Acked-by" tags present in this conversation.

Thanks to everyone for looking into this, appreciate it.

José Expósito

[1] https://lore.kernel.org/linux-input/20220108194235.14401-1-jose.exposito89@gmail.com/T/#u
