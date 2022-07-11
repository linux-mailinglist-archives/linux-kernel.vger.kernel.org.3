Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3883B57052D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiGKOPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKOPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:15:35 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B272E9C0;
        Mon, 11 Jul 2022 07:15:34 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 136so8931751ybl.5;
        Mon, 11 Jul 2022 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ix4O2cAc2pqsm/yRTiT9kWoGMUxUU7qp/Fyo8plM1cA=;
        b=cTTCfqGtaFGZ+SFT/jhxoT87e5ogtYhnJEcyTzj3Z5lfSxCtnwWBgcmbsRYIUbNXnf
         xJCYCN/yUjcCOmncmokzesQ6DIG2UQSSPGSTxNuqb70SspNU4OpX1+z/OAq74TEH6C3x
         GYmwKK2MYiIcaYOVbTatc0FOTr4ywxMf35H7adirzJ1xISOdUgaqJNermE0R49APbNxZ
         Dn074Zw6NrFCx4tZhYuiBnD+KDbd0oQoVUb9kaeGGUbnsZqPjJOEvjVetObWrN24Va6M
         0EDbTOd+7cASrit+fuTiz/trnizN5kCSn9KXUuEceU++n+lspHoZTrL9A/BgIgAv7iUd
         v9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ix4O2cAc2pqsm/yRTiT9kWoGMUxUU7qp/Fyo8plM1cA=;
        b=PKMM2d+kLHa8Z7BYy27KXrUiI5c1QkLmbNKPd91rZBsKtkSScfgbF9A4dtQx5u7Xjm
         4zZMJqyQ8sRcqId3GyE5JvDtbX8NgDdGate7ZYMegTYVi8uOLUkWk1YAfWwpmK6/ylCp
         lDPPI4g2uyaoReMKglvLpGn/47EQbfEx+AAdGKheZaXjLJ00O0nXIhwkrEEw7vP9cl2k
         1X9NeFOwCgfI8Y5N0o7X0xJHf6IAWOv6vum2efR+m2e19KKLU/WDs5rtAXgQ7Mfy8szt
         tXSqdTmgiloR0mylcdzZCPM0ZQaMURBys1/0cCAL3FE5b843nOYmGUXElfSoQUhaqqV4
         oNYw==
X-Gm-Message-State: AJIora9gFR0Amd9mtfkuaLE9DTIBlNyIabvUV30rjEfCjOng8+FFEGFC
        ni+fOMRs2hJbZKQmzqkn7H7UcmA8K9ctu/xF3fk=
X-Google-Smtp-Source: AGRyM1tf30frz7OHaxUhejV0ZdDHvoYvg/3SFqbAGPPfSS3AwqAvh6ZWqpx45V0zmE6drkU04Pn22xREojWPsQI7t/M=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr17313697ybu.128.1657548933686; Mon, 11
 Jul 2022 07:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220711134312.234268-1-tmaimon77@gmail.com> <20220711134312.234268-3-tmaimon77@gmail.com>
In-Reply-To: <20220711134312.234268-3-tmaimon77@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 16:14:57 +0200
Message-ID: <CAHp75VdXsiH9ityqopznRpjxvwOboS_Zbi9iO6nRZ03TuKxTtg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: npcm: Add NPCM8XX support
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 3:59 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Adding ADC NPCM8XX support to NPCM ADC driver.
> ADC NPCM8XX uses a different resolution and voltage reference.
>
> As part of adding NPCM8XX support:
> - Add NPCM8XX specific compatible string.
> - Add data to handle architecture-specific ADC parameters.

Good patch, but one change can make it even better!

...

>         struct device *dev = &pdev->dev;
> +       const struct of_device_id *match;
>
>         indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>         if (!indio_dev)
>                 return -ENOMEM;
>         info = iio_priv(indio_dev);
>
> -       mutex_init(&info->lock);
> +       match = of_match_node(npcm_adc_match, pdev->dev.of_node);
> +       if (!match || !match->data) {
> +               dev_err(dev, "Failed getting npcm_adc_data\n");
> +               return -ENODEV;
> +       }
>
> +       info->data = (struct npcm_adc_info *)match->data;

Instead of above

  info->data = device_get_match_data(dev);
  if (!info->data)
    return -ENODEV;

-- 
With Best Regards,
Andy Shevchenko
