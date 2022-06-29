Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4255F581
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiF2FIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiF2FIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:08:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132759596;
        Tue, 28 Jun 2022 22:08:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id jh14so13038303plb.1;
        Tue, 28 Jun 2022 22:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pDcLiFAR0Y0MAVJaCuzAgJQyO3ufSCiaxhtsTcfbAAY=;
        b=iA7sbQOv1tBUQ5D3Ljfo3xyAX6CBTBHLjTIaQElKTO/tY1G1fu+bR4NlOUW4sxHZrT
         mQni1ZohFaOcm75trXsJ5AaJYX480chy8sGZM8TP3PCyBznmn6Ww7iqlfUWbUMRNrwA+
         BhvyFolvfi2O7E5VbH3LsjAMYs2v+4kR+WV3rqHOPFcb5HsZMjm396EIvslg5N0T8XC8
         Xo2wk61haLtAOAS55tU3l2mImq8HXCbY6JilfgaYECK7t78aScSVAYhrl1DS25dWeyZb
         vwue4yON1L1emXGKvomrp0dmeuFxP87uSBn0Djud6MqKBeesOTuRuNcVsRlDJdWU6/6h
         qIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pDcLiFAR0Y0MAVJaCuzAgJQyO3ufSCiaxhtsTcfbAAY=;
        b=u/6ZcJkzSrLH2y2ZyuREiHWeJhEr4rkFo2V8qrQM0nJ1+OCjMmmmXSXhbTah0nxd44
         k/4UWV6PE+FB7Y4SuPRc6yH5VChCF9QomkWno1l+o5PVi3WcAUTNN8vIXQiOH2AV2LGU
         QiawJ6lTovq/3SJOcZH7Q7QfSEb1ur053VrVGxH+grO1LLhsJfnvvdo9RRm8pTNA+fMM
         1aS2pyJqTttxE69wMJJQWSrXgUUDOB9gLgRn7PZYx2aKfwV9kc5fM8tFNHLrSayEJcML
         Fg11UF5fMU/YHL0fQjUd+UQ2E6ZpulkVd7OyrWUvmOTsn7bFMByR8i+OhGR5dcoTPvkR
         entQ==
X-Gm-Message-State: AJIora+Nih0peqMLqNnCbrvP3aBTaJx0fam8Sj2W0Njrimcd7oshSEGv
        NOiI7ClIZ6v1ZeHVMHFntUA=
X-Google-Smtp-Source: AGRyM1vA84yyYKu6DsK2/zgj9k8TT3PwNLgfpm9qRH8ImuunwcczlD8LfWNtnzlfv7gNDA0L+saH6w==
X-Received: by 2002:a17:90a:404a:b0:1ea:e936:b69 with SMTP id k10-20020a17090a404a00b001eae9360b69mr1760156pjg.133.1656479288493;
        Tue, 28 Jun 2022 22:08:08 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ff79:92cc:7905:3272])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902f38900b0016a51167b75sm10173655ple.286.2022.06.28.22.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 22:08:07 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:08:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [RESEND PATCH v4 0/6] Input: edt-ft5x06 - Improve configuration
Message-ID: <YrveNToV1Sqs1X4X@google.com>
References: <20220621123937.1330389-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621123937.1330389-1-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 02:39:31PM +0200, Dario Binacchi wrote:
> The series was born from the analysis and mitigation of a crc problem
> raised by an M06 type device. The added sysfs attributes were helpful
> in debugging the problem. Patches that change the report rate on driver
> probing, mitigated crc errors on kernel bootup. The patch to get/set
> report rate by sysfs for an M12 device, has been tested.
> 
> Changes in v4:
> - Add Rob Herring 'Acked-by' tag.
> 
> Changes in v3:
> - Add hz unit suffix.
> - Add '|' to description.
> - Check the lower and upper limits of the report-rate-hz value
> - Convert the M06 report-rate-hz value
> 
> Changes in v2:
> - Add Oliver Graute's 'Acked-by' tag to:
>   * Input: edt-ft5x06 - show model name by sysfs
>   * Input: edt-ft5x06 - show firmware version by sysfs
> - Fix yaml file. Tested with `make DT_CHECKER_FLAGS=-m dt_binding_check'.
> 
> Dario Binacchi (6):
>   dt-bindings: input: touchscreen: edt-ft5x06: add report-rate-hz
>   Input: edt-ft5x06 - get/set M12 report rate by sysfs
>   Input: edt-ft5x06 - set report rate by dts property
>   Input: edt-ft5x06 - show model name by sysfs
>   Input: edt-ft5x06 - show firmware version by sysfs
>   Input: edt-ft5x06 - show crc and header errors by sysfs
> 
>  .../input/touchscreen/edt-ft5x06.yaml         |   8 ++
>  drivers/input/touchscreen/edt-ft5x06.c        | 103 ++++++++++++++++--
>  2 files changed, 103 insertions(+), 8 deletions(-)

Applied the lot with a few small adjustments, thank you.

-- 
Dmitry
