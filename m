Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B40F517B53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 02:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiECA5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 20:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiECA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 20:57:31 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1765DD1C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 17:53:59 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 125so17632735iov.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 17:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNXNgphksGo4k32JcFbuZKqXbM115Hb6FPq1B94vQeM=;
        b=Rezn3JQ6zF/Pi8M9aA1wO0xhxWizrPKMRDsqUGbYAZg8yqFRWcJaRypJtv5uRCgFXY
         4u0tvKxQjQ0mcYDb6Pln0swgyB2V5ucmZbpaxNutSb8utdI7qglXN/vdRtWK4U83G2nr
         g6sOuiwjhlNvebxssQuFwKNY5T1P6wRvS3uIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNXNgphksGo4k32JcFbuZKqXbM115Hb6FPq1B94vQeM=;
        b=HuLY4x+yA9SdokaGmwMySOkIhkUW2qb0uWA12suH13GA5KK5bpiyVEWmtibh2FTVWI
         POp/DFNH9u0xqoJS7z2+mMD6J3+XTb32MYjB/1NgtNnfpZs4CMu749/mh7HBc5AWCu12
         GyLVn7agJ1tyKXit/6mr9V95i13q9nq4SOg8oPDVpzxORfb59QLiXve2EkpQZqsosmI4
         QqDOQ6mvwpJ2ofA6WruLiLI8angN71LUNeb3qt25P51HFVYmCLwBZEvWFKNLNkz4zxae
         xp9zDRQSLY3vw4NHwFm+3dt0AedK+1X8/Tb7zk1hEIPw0VrV5oyq92kAvOUmeunHqmEJ
         wwNA==
X-Gm-Message-State: AOAM531cUwz+exCZC7XgwmngzcIj8VQsH8P7n5DSMWmnBsz5cwz8vd1C
        jwDDDPt/ncp18wfTB/qwJ6ED/PmrgcrJ1Xkn8YCiRP7fTG/WZQ==
X-Google-Smtp-Source: ABdhPJw3w4b9qZ7bxbY+0GUCILNFuzlVGSUn99TvdEm0g+1Qi7nOeOfG/n86dBAPua1rUpWz+FsC7/BlTV82HpJFeCo=
X-Received: by 2002:a05:6638:4905:b0:32b:5bc3:4e3 with SMTP id
 cx5-20020a056638490500b0032b5bc304e3mr4528580jab.37.1651539014154; Mon, 02
 May 2022 17:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220503004156.3559940-1-swboyd@chromium.org> <20220503004156.3559940-2-swboyd@chromium.org>
In-Reply-To: <20220503004156.3559940-2-swboyd@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 2 May 2022 17:50:02 -0700
Message-ID: <CAPUE2usLO-sJLP64ZgBrzYBwuZf2tSvKvr9GxcVEiQk7d==OiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: sx9324: Add CS idle/sleep mode
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

Nit: you may want to add an example.

On Mon, May 2, 2022 at 5:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We need to configure the sleep and idle mode of the CS pins for this
> device. Add a DT property to do this so pins are in a proper state
> during sleep (either hi-z, grounded, or pulled up to vdd).
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../devicetree/bindings/iio/proximity/semtech,sx9324.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> index d265eb5258c8..6cec3481c8b2 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> @@ -126,6 +126,14 @@ properties:
>        UINT_MAX (4294967295) represents infinite. Other values
>        represent 1-1/N.
>
> +  semtech,cs-idle-sleep:
> +    description:
> +      State of CS pins during sleep mode and idle time.
> +    enum:
> +      - hz
> +      - gnd
> +      - vdd
> +
>    semtech,int-comp-resistor:
>      description:
>        Internal resistor setting for compensation.
> --
> https://chromeos.dev
>
