Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C620587C61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiHBM0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHBM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:26:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFE9262C;
        Tue,  2 Aug 2022 05:26:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id i71so6676946pge.9;
        Tue, 02 Aug 2022 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CEyoRLt73L4ptaIQtwUnOmwWUaXZTtgT558KC4kMjDo=;
        b=QwCB/MjplYuFCWFMoGQ/T6r7iJWpPoRara6AuXbDMFuuUnVRhu06JJTGQsGaUCKGbW
         gUH+rCa4wHPPX3f+kkYKhmU4mlzNAOZ0v8nc6gDJylHvZarSZaUwhkth/OVyxy/JiT5U
         aliJU3QFZNWdQ1bnNeA2d8lSzcns1jJYCdjQZ5WpwsoALrEfM4Ntv4gwE7VcWcg/WSSP
         ytE/5qqY/2YHRb54oNfCBRyAmWjDhVsqplGAgBU6NJzTE1BPVRHxDYKbaHgCx2zT6i7z
         XUMFemgr/os5kacMi+PL0PLssuH5ECbdk1ZFi3XiZACxAy3S8uA+FUfyUgI/W1NMcS3w
         dj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CEyoRLt73L4ptaIQtwUnOmwWUaXZTtgT558KC4kMjDo=;
        b=xgnXeM0jHX/vcAWf55yk9lVuLAsWDApzrK2IrTB3WZakJ7Oe90C1a0WAw+RZkNelYT
         emXzP8FRZCLDBS+XIvxHLpmQczQLHpBJGtU5yFnSt66uLi02wSz9HLdMIXtfj1sDy3RQ
         9Pnxl0P5JkaNF+DzS4/dvqh9yczgTZDISmIETN+xO5Q8POromIcO7ao+Y95KXvrasOaT
         eU8er3mnlAFvBMZopZtV7Oj9EyUlYZhIPaoj1CNOzCySBdGzp+3pF9Adfbv0Xj63AIzH
         hWO+mhlFoMTc7EtDlxAlf+E1Zsc2znsDSAquEoz3n0cOf2yGS05dGSSeU7Kjni8WJjgp
         vR9w==
X-Gm-Message-State: ACgBeo0KPgNFjEtAsR1jdx/ukaidMyqsDfbGMnVljxvKET1mIDXhZ6ZE
        xt9FH2QkmflJPmzU9Qn95YCmEa3xA9hE21u2zcg=
X-Google-Smtp-Source: AA6agR4XjliuKbxJIsGetzxBKkxJXvX3PtQ1fcTQhPi2+kBszYQVaHO18HgneprDRmRcg6sUPSi6Y+gYYO5Am9OURto=
X-Received: by 2002:a05:6a00:189d:b0:52d:d4ae:d9f2 with SMTP id
 x29-20020a056a00189d00b0052dd4aed9f2mr3525277pfh.2.1659443166655; Tue, 02 Aug
 2022 05:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
 <20220802070518.855951-3-nagasuresh.relli@microchip.com> <08b60fe9-6e89-b10e-dcfa-5a0d53912676@linaro.org>
In-Reply-To: <08b60fe9-6e89-b10e-dcfa-5a0d53912676@linaro.org>
From:   naga sureshkumar <nagasuresh12@gmail.com>
Date:   Tue, 2 Aug 2022 17:55:55 +0530
Message-ID: <CAH_iE_2tXC80hCBcfx3X2-P+i_b6iosb=pAt5QT2Cs8gBWpzAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] spi: microchip-core-qspi: Add support for
 microchip fpga qspi controllers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof and Conor,


On Tue, Aug 2, 2022 at 3:56 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/08/2022 09:05, Naga Sureshkumar Relli wrote:
> > +
> > +     qspi->clk = devm_clk_get(&pdev->dev, NULL);
> > +     if (IS_ERR(qspi->clk)) {
> > +             dev_err(&pdev->dev, "clock not found.\n");
>
> Same comments as v1.
Ok. I will update it.

Thanks,
Naga Suresshkumar Relli.

>
> > +             ret = PTR_ERR(qspi->clk);
> > +             goto remove_master;
> > +     }
> > +
> > +     ret = clk_prepare_enable(qspi->clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to enable clock\n");
> > +             goto remove_master;
> > +     }
> > +
> > +     init_completion(&qspi->data_completion);
> > +     mutex_init(&qspi->op_lock);
> > +
> > +     qspi->irq = platform_get_irq(pdev, 0);
> > +     if (qspi->irq <= 0) {
> > +             ret = qspi->irq;
> > +             goto clk_dis_all;
> > +     }
> > +
> > +     ret = devm_request_irq(&pdev->dev, qspi->irq, mchp_coreqspi_isr,
> > +                            IRQF_SHARED, pdev->name, qspi);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "request_irq failed %d\n", ret);
> > +             goto clk_dis_all;
> > +     }
> > +
> > +     ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
> > +     ctlr->mem_ops = &mchp_coreqspi_mem_ops;
> > +     ctlr->setup = mchp_coreqspi_setup_op;
> > +     ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
> > +                       SPI_TX_DUAL | SPI_TX_QUAD;
> > +     ctlr->dev.of_node = np;
> > +
> > +     ret = devm_spi_register_controller(&pdev->dev, ctlr);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "spi_register_controller failed\n");
> > +             goto clk_dis_all;
> > +     }
> > +
> > +     return 0;
> > +
> > +clk_dis_all:
> > +     clk_disable_unprepare(qspi->clk);
> > +remove_master:
> > +     spi_controller_put(ctlr);
> > +
> > +     return ret;
> > +}
> > +
> > +static int mchp_coreqspi_remove(struct platform_device *pdev)
> > +{
> > +     struct mchp_coreqspi *qspi = platform_get_drvdata(pdev);
> > +     u32 control = readl_relaxed(qspi->regs + REG_CONTROL);
> > +
> > +     mchp_coreqspi_disable_ints(qspi);
> > +     control &= ~CONTROL_ENABLE;
> > +     writel_relaxed(control, qspi->regs + REG_CONTROL);
> > +     clk_disable_unprepare(qspi->clk);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Platform driver data structure
>
> Same comments as v1.
>
> > + */
> > +static const struct of_device_id mchp_coreqspi_of_match[] = {
> > +     { .compatible = "microchip,mpfs-qspi" },
> > +     { .compatible = "microchip,coreqspi-rtl-v2" },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mchp_coreqspi_of_match);
> > +
> Best regards,
> Krzysztof
