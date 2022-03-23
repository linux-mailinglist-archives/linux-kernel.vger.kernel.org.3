Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100704E581B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbiCWSIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiCWSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:08:50 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8526888E4;
        Wed, 23 Mar 2022 11:07:20 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id y3-20020a056830070300b005cd9c4d03feso1619301ots.3;
        Wed, 23 Mar 2022 11:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2mGmOPHJ7+RA73j6bZcuSzfgGUyVcCTQ8/kiyLCy7vc=;
        b=xXgzPr4mXSsr0XK6hk4yqOFY8quEpyAI8X5Y9qdK0MsNz/lfncJ0knkhCniEZ8VMLI
         sNGhhWEiRI2RgcaNATx8Djc36lKD2Lar6N3U+hrJHtEcEpWO+xa2qU5pozEZtu591bRT
         Wkdw+V49g2KX7/+c3gt2KjnjpwhwdNqNdPTb6HNt8z0Zinp4jYYCxAMB52NeSUAXuwKX
         EiUedDCqy7iANfqgJYwmPrPjKu/RO11fkP08saMnJqOBXuXRJyIrLHnFkRJL6O7EkdQi
         YBHHSQtO8PPYpV6zEt5HjxoGFY8GM/II5JCOa6miiQ2x8sMqDfshlPIzG4GTijE8Doks
         wiJA==
X-Gm-Message-State: AOAM53226T/3YTO2+u7x9E2tD06uCzOpezERv8asmAPe9ZGem+caPvPU
        XkL0hCLb91ee7tC+aeVFeA==
X-Google-Smtp-Source: ABdhPJw/EhNofizCEXIXPzxmAs3l3IBLf0YzIPbigyV/R+R/dgdStWja2bBqluNpigjz4mTlFeMvwg==
X-Received: by 2002:a9d:7842:0:b0:5b2:4dee:79c2 with SMTP id c2-20020a9d7842000000b005b24dee79c2mr532888otm.53.1648058840117;
        Wed, 23 Mar 2022 11:07:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 60-20020a9d0642000000b005b22a82458csm283573otn.55.2022.03.23.11.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:07:19 -0700 (PDT)
Received: (nullmailer pid 181456 invoked by uid 1000);
        Wed, 23 Mar 2022 18:07:18 -0000
Date:   Wed, 23 Mar 2022 13:07:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Subject: Re: [PATCH v1 0/2] Add USB HOST OHCI driver for Sunplus SP7021 SoC
Message-ID: <Yjth1mAtn/hX2Xvx@robh.at.kernel.org>
References: <1647235924-15572-1-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647235924-15572-1-git-send-email-vincent.sunplus@gmail.com>
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

On Mon, Mar 14, 2022 at 01:32:02PM +0800, Vincent Shih wrote:
> This is a patch series for USB HOST OHCI driver for Sunplus SP7021 SoC.
> 
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
> etc.) into a single chip. It is designed for industrial control.

Looks to me like the generic-ohci binding and driver should work for 
this?

Rob
