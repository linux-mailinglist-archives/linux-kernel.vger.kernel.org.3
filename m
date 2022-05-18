Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171D652BE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbiEROym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbiEROyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:54:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F2A1BDD93;
        Wed, 18 May 2022 07:54:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f4so4045005lfu.12;
        Wed, 18 May 2022 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMb8zkMkHCIlccAQjA5BajELKr84CtL4aU+80NzrBEg=;
        b=b+IM7oTc+2Sg5GtM8rqGckVb60cRnoSyUWNrDUSq4WjyFV8SDg7k8lhDYocGihdoyF
         jla9SwofdDpAh/1+ibGoHv8JZtjTmeVtJ69fOJvdYIH8UdWjqYcABZOEQIQaKwJljqvg
         S0I2/Tb3YWbJD4VhCT0dqYI4mSN1DkmWa1hqHkas9cmuc6guuk8cru65jz/4zJRtOrZI
         2CSRTJzjhDwTjUftG5R8ayIBFUlnrJySdVaU9ZUzegc+tc+t5Boc2t3hGy5hpihgcS6J
         lABvT3wr01VlL9q/uk+pUWTg0XrVe+bG7Oqp4kk+YfmqgtJWWoqhrTJq5gkC2IbfYIiY
         Ns2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMb8zkMkHCIlccAQjA5BajELKr84CtL4aU+80NzrBEg=;
        b=dedHj8z+qV7+s10GNrDzg8OSw/i/h5LjHipa7B/HU3XSQAepmy+769fDT34uAGiv7A
         e29wGEk1ytXcnO8FgC40/gSr5PPPq/aAiYrGGhPVHKVweh63UGPW2j9d0L8mwm+wDkTi
         3JqxEHsygSk1jQKlE1f0hSOsEvvQA3oCebuPhxgmC9YGHSj8zDVKYiZDln8AyXBMfzg+
         Jk7r+kqjy5X9ODuT3HJ27Fb+Z+uydBJVkSjby2mzfLXeEB5O7KDM0Ftqu3nz/juhrkNf
         3diWTXMBF3fkns99gMRNrbCTjfRP/KpSYAl8uXz7/Mszz4Q7jMPDi67lYVXHHBCfC9ux
         w/FA==
X-Gm-Message-State: AOAM531qkhTMEeL+cp8qIgUQaigq0ssuHaQfIk2NKAhfnPyY4QNN7rtD
        koLjxiugURba44dGk3u38So+rH4MXqPCdBLeSg4=
X-Google-Smtp-Source: ABdhPJwrn1b0ZbIHFlR6mnNjQUgmrl6lpUFPZY9C5H3RcIBSs9kLt9EgLSPIfRQpIVj27/3sQlUuczGBv4Cs704NTLc=
X-Received: by 2002:a05:6512:3d15:b0:477:65d7:7635 with SMTP id
 d21-20020a0565123d1500b0047765d77635mr16383955lfv.656.1652885676135; Wed, 18
 May 2022 07:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220516115846.58328-1-max.oss.09@gmail.com> <20220516115846.58328-12-max.oss.09@gmail.com>
 <CAOMZO5DhTNDHLt_VZoWqD5dMBHq3rvJ+0j8-4xHHThyqheqcgQ@mail.gmail.com>
 <CAEHkU3Xtm9gk6xXr586M3pm4tPpFA-fGn+QyKXfF+Cqqa8VK8g@mail.gmail.com> <CAOMZO5C+6Hoh8Sq4eZp+pp-0ktroz9MJw2-cD5eZEhBZGx+Wfw@mail.gmail.com>
In-Reply-To: <CAOMZO5C+6Hoh8Sq4eZp+pp-0ktroz9MJw2-cD5eZEhBZGx+Wfw@mail.gmail.com>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Wed, 18 May 2022 16:54:24 +0200
Message-ID: <CAEHkU3Ue5FaiKsc8BSyfpAyKjsP27PML1AwEqa_VN4V+kZPD5w@mail.gmail.com>
Subject: Re: [PATCH v1 11/17] ARM: dts: imx6q-apalis: Add ov5640 mipi csi camera
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio

On Wed, May 18, 2022 at 4:25 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Max,
>
> On Wed, May 18, 2022 at 11:21 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> > In my (limited) testing I saw no issues that the camera would not come up.
> > It takes 2 to 3 seconds until the pipeline is running but I noted no hickups.
> > I did this with setting the resolution to 640x480 and 1920x1080 which
> > probably would not relate to the LP-11 issue you mention.
> >
> > I.e. I set up the v4l2 pipeline and start capture to the screen as follows:
>
> Just curious: which baseboard did you use to test the ov5640 camera?
>
> Most likely there was an issue with the customer's baseboard that
> prevented the camera capture to start.

I used an 'Apalis Evaluation Board' with an 'Apalis iMX6 Mezannine V2.0A'.
Now I did retry and it works equally well on an 'Ixora V1.1A'

Note that in the beginning the camera module required the SoM to provide
a 24MHz clock. The V1.1B HW version then got its local oscillator and the
clock input no longer requires a clock. That may or may not have been the
issue your customer saw.

Max
