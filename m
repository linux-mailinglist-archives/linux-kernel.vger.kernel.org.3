Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C68505C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346307AbiDRQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbiDRQhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:37:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4B231377;
        Mon, 18 Apr 2022 09:34:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k23so27789824ejd.3;
        Mon, 18 Apr 2022 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vc1/uJ90DYtW5k4IaJRODfqMSNp6eKUlYbKQbzA11n0=;
        b=o0i3eE61fiSCrCyF/xPgvH5k7NIpTbfVylZ3e6fhDcS0T4pzayzX/ldIjKRT8mNKvt
         P1ZvYoID4e5gLtOkD0H0JC8dYrCk7fbg/Zzfq8BWUWFjsjmPk0D6rlF5caR1ciKlRSwS
         sZ844hpWHh2Mxd7iMWtE3dcxaNot5y+0HkvzQNaFQK1yKq1/b2fnBKlmLYCoX+B5FA1K
         SNuLq91l5rGYOShiOCZ/u6b3QNBXWyoIAkTBU5LeeexUc9j1k9W95Ba02i2PLyK+q3hM
         D6CXsSgErbvCGwB74hon8yvzxmP37KS9g7OIqIBLT2+8StvFS2oXlEJLrXWHKuRXuCPY
         95AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vc1/uJ90DYtW5k4IaJRODfqMSNp6eKUlYbKQbzA11n0=;
        b=AAwz6U0kx3EwKoLoukJg5ngWIBcdlCgX/8ibMUa4eHK24slg4It6PYaxqSrx1kI4uW
         mPdgUWFUs0b5yWpx5KbJKkehNVA1X6J6Texi/Riy6oPus9upZG3voESbmqXsGlvC/xjo
         0ruj7PYMZ8TcUNMi683Df45nnfmsXemCcwAJf7sUQH/ann1PVJjswe6pJ15m3yaZ9z2g
         At9hRkW+JvR1jgBpBYI2SQrh4k1le2g7F0zhYMy8+g+lklocMQzBrTi9WMnjuxlqUyJN
         dQY+QjBJYlFXtrUod47uySJ6/83fhavGO0ZFqGf2u1d3mzc7WYScjz6BuwvkqAACrvOk
         HqPA==
X-Gm-Message-State: AOAM530ELs/Pph2gUsNRxK3WKWU6AUDZbSjJi+Ib987PHu+5izZ2/f2y
        odcfgXA+QkgIhQHOt/Tf4hlw7hy6E1Uj1wBeH9RSGI7jwCM=
X-Google-Smtp-Source: ABdhPJySQrxGT5J7CLUjI/JmzzbA74ki0jYXo4we1cUnH4IGawnJX4vvjn7i+Y85FkME9yL0YKyey/dqUbAyiMm0AZY=
X-Received: by 2002:a17:906:9b96:b0:6e8:6e4c:8249 with SMTP id
 dd22-20020a1709069b9600b006e86e4c8249mr9807402ejc.281.1650299670653; Mon, 18
 Apr 2022 09:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220407154338.4190674-1-p.zabel@pengutronix.de> <20220407154338.4190674-5-p.zabel@pengutronix.de>
In-Reply-To: <20220407154338.4190674-5-p.zabel@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Apr 2022 18:34:19 +0200
Message-ID: <CAFBinCBiypQYfJ6ZMoNnHXFCviOzpHs4WvCrSfPZAy7Q7GTVHA@mail.gmail.com>
Subject: Re: [PATCH 05/14] dt-bindings: reset: lantiq,reset: Convert to yaml
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
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

On Thu, Apr 7, 2022 at 5:44 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Convert the device tree bindings for the Lantiq XWAY SoC RCU reset
> controller to YAML schema to allow participating in DT validation.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I am not sure who can take this patch (through which tree).
Maybe Rob can simply take it through his devicetree tree?


Best regards,
Martin
