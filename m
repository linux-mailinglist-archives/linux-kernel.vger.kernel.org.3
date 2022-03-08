Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9794D1FBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349396AbiCHSLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbiCHSLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:11:06 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB95642C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:10:10 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0040D3F4C2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646763009;
        bh=P5NfD1dxp72/Z/UJR5oJ5juKBT9hEONgDz/FvaCJI40=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jSzKNQ/w58XuU2p4z4aXPdeR3XWy32BU4Vu/23BqPC9TWH6DUyGo3MVtlZEC4QKCO
         ec4jTXLEkG2dPm7fkLbI9Stu7XwDrkuTQepaCHKCZEp/vuzyuyqqeinj1ozpkmbFBH
         KtLcUcmEeXyNtsD8JVDlWBV2StZ2AypBF3AgEVIBue0tqA3+QaudHRAtXhmDyZYDyJ
         Bi5dvknVplyl7hH0hxOwM2gE1N6l+JbfXuGGZ/URvmjSZIKQEfa2TqBFyabQYNKNPG
         IXw6OnYMYoMExevQinDgBj7dxl2uFGGsW9w3MVOdnWZZjMOlgVPYSKCNj7CEEeTUep
         bSepUhObacpSg==
Received: by mail-ej1-f70.google.com with SMTP id jy20-20020a170907763400b006db62b6f4e0so193807ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P5NfD1dxp72/Z/UJR5oJ5juKBT9hEONgDz/FvaCJI40=;
        b=4dPtmlae/uCjDr4JAXo+8qTi/HeOMy6KxZ1QLjm54llzTpfkPpAxntbti6bCe1lUXe
         7elZ3mC2XURs6E9xH2W45K4DFZruB7nmoLAV0H6Ee/m4lyziL3H3CKF4lPJ0HRJ1dV5u
         YDSYcaz1rmcxWTvipKtmjVVUAxHB5fNet7gFr/jhN9PyuTX+ddl52Aab09YFC+Agbrbo
         5Wfm79PEmnQbqWjxgEuquXgHMmhny+2MEZ73Y0hdrD7HSkznmWDMEK2J5PsAXJrLYzV2
         +L6qrMM+xCd4XTzv6gpgTB7UUpMnoBTzAW6L9JucxZuGndf3hm/jLhNvQA1VZY1qo4H3
         X2YQ==
X-Gm-Message-State: AOAM530fuZZTxxalMTVzvmz/D2QKGd1154U5hLnYmElOx/klDtbVWYVp
        gdS/CWtDox+v3K1pPwU3np7euesWfTvmis4npdXHYh7ojS7xKGlrTC710bmghrDBqDJteApX2QR
        VO/REchwr7uHXCbbar9YkTZgKS7fvJ0rBD85UOMSjNw==
X-Received: by 2002:a17:906:2a50:b0:6da:ed06:b029 with SMTP id k16-20020a1709062a5000b006daed06b029mr14158901eje.506.1646763008685;
        Tue, 08 Mar 2022 10:10:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdsvPNPxGbwShrZZxnDXdfQoC5eYJxtPkPGLQtGTq+xlcflRFTJjtk66/HeJ0oH8kS8x/sSA==
X-Received: by 2002:a17:906:2a50:b0:6da:ed06:b029 with SMTP id k16-20020a1709062a5000b006daed06b029mr14158874eje.506.1646763008423;
        Tue, 08 Mar 2022 10:10:08 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id qx13-20020a170906fccd00b006bdeb94f50csm6141273ejb.203.2022.03.08.10.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:10:07 -0800 (PST)
Message-ID: <e80dd94a-633c-b1be-64c4-1c8fbdfd677f@canonical.com>
Date:   Tue, 8 Mar 2022 19:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/15] dt-bindings: devfreq: rk3399_dmc: Add more
 disable-freq properties
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
 <20220307160918.v3.5.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307160918.v3.5.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 01:09, Brian Norris wrote:
> DDR DVFS tuning has found that several power-saving features don't have
> good tradeoffs at higher frequencies -- at higher frequencies, we'll see
> glitches or other errors. Provide tuning controls so these can be
> disabled at higher OPPs, and left active only at the lower ones.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changes in v3:
>  * Add Reviewed-by
> 
> Changes in v2:
>  * hyphens, not underscores
>  * *-hz units, and drop the types definition
> 
>  .../bindings/devfreq/rk3399_dmc.yaml          | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
