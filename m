Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE46476350
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhLOU3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:29:31 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39658 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhLOU3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:29:30 -0500
Received: by mail-ot1-f51.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso26321099ots.6;
        Wed, 15 Dec 2021 12:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agAmJrAHp4WJOo55DBZF6jiUaB3K9dubsfqlOWvl1sI=;
        b=luPk83VxHJiOenjyPEYi6CoZN+GwIoSH+7ubUgmQ0K2m/LcTMHPTGqu0vDXJBtyGtI
         msWxwKM1LR6N9c20BZ5BBdP/TpoyqkKjDt7QCOEL7JE+kPEZQfz+MtTY19VBqFgZjxuk
         +2TEUU8WkiC7Lzca+O3+MftwOePpLfJvHmAtGTka8or5n7LxmrRJp/oOaU6rcEWwlKQY
         jrzknZtH7HCBL4/O7gjXn8i13w+AntoYLM8UyjwCBY2JBwsxZmhKbT7t1nd3yKr2VJQX
         H+qK5655kcoLaJeimATGDr0du4exKfGA97dg2WQPekMlcS4j466PV43oojuHH/9aFSw+
         8DSQ==
X-Gm-Message-State: AOAM533q51pLSHMhxeD2wiXRyRJeqmzIkfen74CwQWvELNeJ0cqpjYnS
        DooYeODFIebN/90vtg+JPw==
X-Google-Smtp-Source: ABdhPJz9yUol/9bNBhhW7cpZ2jGbw20gyt4RO4u1F4JQBcIkMG+mhJOkyFi0L7NloVWIsLaailAEMw==
X-Received: by 2002:a9d:77c6:: with SMTP id w6mr10382149otl.155.1639600169412;
        Wed, 15 Dec 2021 12:29:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t11sm638861otj.24.2021.12.15.12.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:29:28 -0800 (PST)
Received: (nullmailer pid 1784906 invoked by uid 1000);
        Wed, 15 Dec 2021 20:29:27 -0000
Date:   Wed, 15 Dec 2021 14:29:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 2/3] dt-bindings: gpio: Add a header file for Amlogic
 Meson S4
Message-ID: <YbpQJ3D6UrMckg02@robh.at.kernel.org>
References: <20211214022100.14841-1-qianggui.song@amlogic.com>
 <20211214022100.14841-3-qianggui.song@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214022100.14841-3-qianggui.song@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 10:20:59 +0800, Qianggui Song wrote:
> Add a new dt-binding header file which documents the detail pin names.
> 
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
> ---
>  include/dt-bindings/gpio/meson-s4-gpio.h | 99 ++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/meson-s4-gpio.h
> 

Acked-by: Rob Herring <robh@kernel.org>
