Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA1346EF2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbhLIRDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241916AbhLIRDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:03:00 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6755C0698C4;
        Thu,  9 Dec 2021 08:59:26 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z6so5952868pfe.7;
        Thu, 09 Dec 2021 08:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xEge/hk2eN3BabVptokevaVEr4JlxJ5oV5yaJ6wABCk=;
        b=OjV7MlbtFtPC7WEbokYp3V6lqzlmPZcOyXEDAFi0MMl2wz0HgGDtJsLDuDEGFwOkXx
         fUEUeuJQfUCIhQMbjt+vHIKz8HoP5robjIPg4ADxh9AAOzW1qCIEPF9Oct8HhR0Slyxa
         YSEvjhHPiXiWqZdHDxKucgHSe/8abnM2B6JlmbdjgZnNNakIxA/Q3zNjTO7gYxLqb4YR
         nscqae3Ex6cJ4Y3Urf/ErwqXQZF71S3WmI5t9AF27sm1l9XYF4lKygICp0BzO56+R2iV
         2PAgG8OOJaG3fYjcXOgGbgQYXsCjogZG/OdRnrrvs9RB1dmIm/D+P6r/jLc5D0aSWG0s
         PE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xEge/hk2eN3BabVptokevaVEr4JlxJ5oV5yaJ6wABCk=;
        b=oSKBhLOYJUgWaFlwzSo/KqM3+cLnhp6Ply0Ha4ywvwAW7MpPqts8S8/k7IXRL9mAd4
         XsQse2t8KuGHD5R78M3jaEEQel+RGWb2ZXAdbyfVx89jjYRtpemV1ihAftPUKALSbzTq
         Zekj5LpuKprWmz9J0u4RhLM+cM4g3HomVrndtG5QPGDuviYEzJJWrvWuqbt9xYYRfNTa
         vcIdY6vn0c6C+68dGbZi1MJSwNYXr36K3cSmPVYA4JB4CYoVqdYdOOjGBSx+shEKuFmM
         WPFC0TwP7DSD0E6OWWeto++fLwvxcvKagVGowsBmLR7OJ0Dt9qXNZqLbDtNesCkiAASl
         Bt3A==
X-Gm-Message-State: AOAM533bqXentm1wRt8TkT/+SX3CvgqFs9qr9gVHKx84CRygLGenhlfT
        JsO9ls7TFqtN/sNTzCa+WrhY+uAcP40=
X-Google-Smtp-Source: ABdhPJzBV4CLqpERUJ/MGt9P6/fPZdAQbxWpCC+O9Az+thHkMNAH9y2gmdqMGad65Mqtox5yHWwytA==
X-Received: by 2002:a05:6a00:148c:b0:49f:e048:25dc with SMTP id v12-20020a056a00148c00b0049fe04825dcmr12891120pfu.12.1639069165839;
        Thu, 09 Dec 2021 08:59:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id hk18sm10208235pjb.20.2021.12.09.08.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 08:59:25 -0800 (PST)
Subject: Re: [PATCH] gpio: bcm-kona:add const to of_device_id
To:     Xiang wangx <wangxiang@cdjrlc.com>, linus.walleij@linaro.org
Cc:     rjui@broadcom.com, brgl@bgdev.pl, f.fainelli@gmail.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211209131245.23172-1-wangxiang@cdjrlc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a3057939-25a2-5d4e-1b38-54436db6560c@gmail.com>
Date:   Thu, 9 Dec 2021 08:59:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209131245.23172-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 5:12 AM, Xiang wangx wrote:
> struct of_device_id should normally be const.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Would be nice to add a space in the subject and do:

gpio: bcm-kona: add const to of_device_id

While applying if not asking too much from maintainers ;)
-- 
Florian
