Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8744F9930
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiDHPQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiDHPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C801226DE;
        Fri,  8 Apr 2022 08:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618D961F2B;
        Fri,  8 Apr 2022 15:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAD2C385A6;
        Fri,  8 Apr 2022 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649430878;
        bh=+Kufa04u/zTqHEB/EmRSK2XieqNMNPkuGKRCwWhmIf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qSsEHIx6qX0TF3sqA70nkE93eIftID8aXw3VXGlaTA9glKX+NrCQwnOoCdqohCBHO
         L62NtdkZq9FDH7D7KUrv46V10iu8lFvlr7KpO2sPIyusvIumFcsBBY+ztiigX1yB/m
         o/yeqWIoJxHAhwz6cIdPw9zbx5y++KIdNYTSIs4ukpcr0GGseJGQXzQhnoyJc/Hz8d
         KD8ywBQXMtT1ld+s4E+A/QhGfrXsO8oiWpLmUusqceVdoS6xU9r1O0jg5sIHXS9N3l
         EZSYzO3xMOIn7pGUExBYtHGi2yX1vAxTb5CfKIRKEv4nCcrS4myHWe8UK15X4MpsCl
         qk9WGH5ZOE7KQ==
Received: by mail-io1-f50.google.com with SMTP id e22so10921391ioe.11;
        Fri, 08 Apr 2022 08:14:38 -0700 (PDT)
X-Gm-Message-State: AOAM531o12EPDZIfm3boq/6D1nYBiMSK8PrGuVoICJ/IuwyE7z9y6lhS
        1VIdtYUbBTCV2+ooAQHSIo7DJ9WXXGxgHDCcfA==
X-Google-Smtp-Source: ABdhPJyvoPkgbO5fUHoeXR4IWB1C6fLbSqDw3ETopX4sc2/uj7NKpf9ehCnpwiEK3iKvALIDOsmDbC8OtHxAVtJOJ20=
X-Received: by 2002:a02:cc42:0:b0:324:272f:d6c8 with SMTP id
 i2-20020a02cc42000000b00324272fd6c8mr3839994jaq.247.1649430877907; Fri, 08
 Apr 2022 08:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <35ceac23-2841-7def-d963-484d1a489836@csgroup.eu>
In-Reply-To: <35ceac23-2841-7def-d963-484d1a489836@csgroup.eu>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 8 Apr 2022 10:14:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJwcS5VhhOwqV7258YC2zvb759UBt5cusn7f_niswdxbA@mail.gmail.com>
Message-ID: <CAL_JsqJwcS5VhhOwqV7258YC2zvb759UBt5cusn7f_niswdxbA@mail.gmail.com>
Subject: Re: What means "sysfs: cannot create duplicate filename '/devices/platform/ff000100.localbus/d0000044.gpio-controller'"
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 3:16 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Hi,
>
> During boot I'm getting "sysfs: cannot create duplicate filename
> '/devices/platform/ff000100.localbus/d0000044.gpio-controller'"
>
> Below is a grep of "d0000044.gpio-controller" in the log.
>
> Any of what the problem can be and what I have to look for and do to
> avoid it ?

Do you have 2 DT nodes at the same address?

If not maybe something with fw_devlink is screwing up. Can you try
disabling (there's a cmdline option).

Rob
