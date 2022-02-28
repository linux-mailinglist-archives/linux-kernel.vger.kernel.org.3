Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0F54C615E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiB1CpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiB1CpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:45:12 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A030F1CB38;
        Sun, 27 Feb 2022 18:44:34 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id s1-20020a056830148100b005acfdcb1f4bso8438184otq.4;
        Sun, 27 Feb 2022 18:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=/qRGHudNo2KzOCPZ3MYbWDMzFzdSswmrfq6gIYo21yQ=;
        b=TRXEuHxDRkFL6ApO5eHM+/LaFUHCBKLC5Fy0Pw8lVaIagHNpclhmxgrBOkFg4oip7r
         ys2WZqiVH2ixfbjW58CqtWQrVhJ7NGsTwOtKrxT4Tam+/yW9Cev5l2kPHWR/U8P56oUn
         EKP/xUFFEKIyPddjoO2V8PiwVIeyZ82T+A8UmRpV8YYtGY6SJcyoJpHl8LH65Vvus4ap
         27Wqokq9uiysWuuPJC++vIFmOuuMu7DoIYuPOQPOQe5GCLaA2GIXfvYWAHugWHMhHaYx
         qjzEdht+qLcjwOsw1vSxctQPo3afOPSCwdcMaGvg4EIvoMBlSo8O1FB8YrMlUlcPjBcb
         MbnQ==
X-Gm-Message-State: AOAM533BFkaQ0OgDTg9KEnXrphMIdITVapT3l24NSbNKaLDnqvMBgvLs
        2xRsSIsKiKU7lRzv4sghQ+b3W3vKzQ==
X-Google-Smtp-Source: ABdhPJzzxKMlfVFaWHZYyKcYwPUmsSew02e4QthzvrfN5L5ZpZFS5NdKefUV6W/dmlX+O8Pf7AHhiA==
X-Received: by 2002:a05:6830:1f56:b0:5af:a42e:fcb5 with SMTP id u22-20020a0568301f5600b005afa42efcb5mr8112423oth.85.1646016273915;
        Sun, 27 Feb 2022 18:44:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u3-20020a056808114300b002d51f9b3263sm5521775oiu.28.2022.02.27.18.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 18:44:33 -0800 (PST)
Received: (nullmailer pid 47198 invoked by uid 1000);
        Mon, 28 Feb 2022 02:44:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     linux-usb@vger.kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, wells.lu@sunplus.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, devicetree@vger.kernel.org
In-Reply-To: <1645955441-6496-3-git-send-email-vincent.sunplus@gmail.com>
References: <1645955441-6496-1-git-send-email-vincent.sunplus@gmail.com> <1645955441-6496-3-git-send-email-vincent.sunplus@gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: Add bindings doc for Sunplus EHCI driver
Date:   Sun, 27 Feb 2022 20:44:30 -0600
Message-Id: <1646016270.937444.47197.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 17:50:41 +0800, Vincent Shih wrote:
> Add bindings doc for Sunplus EHCI driver
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
>  .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      | 97 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml:62:18: [warning] too many spaces after colon (colons)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.example.dt.yaml:0:0: /example-0/usb@9c102100: failed to match any schema with compatible: ['sunplus,sp7021-usb-ehci']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1598222

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

