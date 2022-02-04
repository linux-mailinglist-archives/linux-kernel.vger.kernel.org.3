Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3835D4AA051
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiBDTot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiBDToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:44:46 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2CBC061714;
        Fri,  4 Feb 2022 11:44:46 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id a25so9904439lji.9;
        Fri, 04 Feb 2022 11:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=EY/HGBtjW2B/xy2aoc3hN23r1qYr7cNBzDYndqWrzTw=;
        b=g+8K/t28gvBP8URI8gyn4xeM/nJJS2QwgsRYS3m+nn5wE6bV1tdLD15pD4Q9hqExde
         GEKOH3GC2473wsep4KA3cfw4VNnu5m/EVQTQ+BJuJyPwcMtvhYbBg04AcJbO7/DZlZtu
         J1vYmhIOWlkDNUwVqBzwPczyxsarhszAGNPb+nf4ZOnEprZl7gK2jafRTR51+Mevo8um
         Wongj1+XUkHXQa2ydsqiEqrOTPWmweJI+Pdg5jCSxON7aCAygArzIyFqSA4358CVO8gY
         znF7Ghymc/oZG9TxrpvmC6khfi2ujauXcgV/dH1swrgXLu/5NVxrnOGlB8b4rTq6+Kkm
         CJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EY/HGBtjW2B/xy2aoc3hN23r1qYr7cNBzDYndqWrzTw=;
        b=NzsBb1fTrlJuS1bltIH9xgar7bfzmY5O35d6HtTosAanxK3BXgiNbjB7aCfUS2t9Hp
         KPvsPt8Mu2yf1Cu69mcSLaOEae757CP6GyR/ksAk3BbRMxpF6Tt5lKSo8guNFJVBwTP6
         Wbg46PpTH3v9gL7BYRI2BSsOnqWjIZntINK3uMytzO1/BRkx4ksbStJsxwC48nXtOXg2
         jSQINL64K62VjeHWotOO+DAbz1xnabNHxmsZyRG24+KiEqnA3uqOa8DMcaJOIy0d4chs
         TdUXIyB4Ubw3eOw297ILz9thF0oMCiqo+Yg/B8/wCk6cmXN0Xao0qwNAbGMlHg2T7A//
         QZ7Q==
X-Gm-Message-State: AOAM532f4Al+ySHAyePqaqbGEU0v7UMTe1J8znJcGkLdtW0DNYaRFIig
        3bx+p7zoxggMS+Rg60F6F98=
X-Google-Smtp-Source: ABdhPJxuOUF8waFjTreKMFJweys4aydLGd4j/jKLivhxUQ2oV+ll9crRaDGma8C3NlJDBZX9tYWQbQ==
X-Received: by 2002:a05:651c:1543:: with SMTP id y3mr298803ljp.152.1644003884581;
        Fri, 04 Feb 2022 11:44:44 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id g7sm377390ljk.83.2022.02.04.11.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 11:44:43 -0800 (PST)
Message-ID: <c18415c6-a8eb-0d5e-8ac1-aba57ceba764@gmail.com>
Date:   Fri, 4 Feb 2022 22:44:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/6] dt-bindings: memory: lpddr2-timings: convert to
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
 <20220201114749.88500-6-krzysztof.kozlowski@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220201114749.88500-6-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2022 14:47, Krzysztof Kozlowski пишет:
> Convert the LPDDR2 memory timings bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../ddr/jedec,lpddr2-timings.yaml             | 135 ++++++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr2.yaml  |   6 +-
>  .../memory-controllers/ddr/lpddr2-timings.txt |  52 -------
>  3 files changed, 137 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2-timings.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr2-timings.txt

It takes some effort to extract a concise descriptions of all the
properties from memory datasheets. Thank you doing that! Nice to see
that no txts left :)

