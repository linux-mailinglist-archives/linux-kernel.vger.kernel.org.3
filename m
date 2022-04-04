Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A404F1ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiDDVwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379592AbiDDRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:43:36 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ADE31DE7;
        Mon,  4 Apr 2022 10:41:39 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 12so10784259oix.12;
        Mon, 04 Apr 2022 10:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Gm8Q9IkyRhAeqdPU+N8JCDzIc1jnZK1MiElDRAVrowg=;
        b=IUBHRZUR1CP3Z09zzwDN8OLdIU3U07bDFgwfp9DzAfLqHZSjUyvTkYVKDifPWhJDEY
         HgqG9FLdyQi2fqiXqgbicwQbZMmFUM11LmAPO+n2SXPgHr9O0D6HSBmpoCMoVhyBIZDn
         9Sk/WyQ9G4n2IGYP5rlMdVnx/1qlvpb293G/i8NtkNHMXb8KdLkxdaSJo6IUeLf3tmuX
         W+qOksGIRnDK41UUGBq8Y1YP+Uw1AGiHGySiPenYLMiCZr5mthIBFSUOAKJS7CO2oFe3
         enx5ldHm+i9K15O0+x0RXLqcupcO+9KdXHTvYIMcm+F4ueuvTVb3F5ifLAlJJTqOvAe9
         RBvQ==
X-Gm-Message-State: AOAM531zyOtAi5B5SKJweFoAFCSTnnHGT4vx/JXULeGC/nShkQWZ+4Ns
        A8ISAZey8ULra68Ig6B0Mw==
X-Google-Smtp-Source: ABdhPJzSZ9WfFV7feWqE4tE2BP8FLwzfupkBO4Pv3m1nUPLK+RrkI1IoCe9ioNTKSDmYmbnfBAqL3Q==
X-Received: by 2002:a05:6808:b0f:b0:2ec:f51d:ae0b with SMTP id s15-20020a0568080b0f00b002ecf51dae0bmr131491oij.67.1649094098466;
        Mon, 04 Apr 2022 10:41:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r37-20020a05687108a500b000e20bfd86casm901587oaq.11.2022.04.04.10.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:41:37 -0700 (PDT)
Received: (nullmailer pid 1597042 invoked by uid 1000);
        Mon, 04 Apr 2022 17:41:37 -0000
Date:   Mon, 4 Apr 2022 12:41:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220324141237.297207-1-clement.leger@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 03:12:34PM +0100, Clément Léger wrote:
> This series is part of a larger series which aims at adding fwnode
> support in multiple subsystems [1]. The goal of this series was to
> add support for software node in various subsystem but in a first
> time only the fwnode support had gained consensus and will be added
> to multiple subsystems.

The goal is describing a solution. What is the problem?

What's the scenario where you have a reset provider not described by 
firmware providing resets to devices (consumers) also not described by 
firmware.

> For the moment ACPI node support is excluded from the fwnode support
> to avoid creating an unspecified ACPI reset device description. With
> these modifications, both driver that uses the fwnode_ API or the of_
> API to register the reset controller will be usable by consumer
> whatever the type of node that is used.

Good, because controlling reset lines directly isn't how the ACPI device 
model works AFAIK.

> One question raised by this series is that I'm not sure if all reset
> drivers should be modified to use the new fwnode support or keep the
> existing device-tree support. Maintainer advice on that particular
> question will be welcome.

That would be pointless churn IMO. Why do we need to convert drivers 
which the vast majority will never use anything but DT?

Rob
