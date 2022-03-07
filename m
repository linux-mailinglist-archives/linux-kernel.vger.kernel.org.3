Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE6D4D0B83
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiCGWxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbiCGWxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:53:40 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D8DBE8;
        Mon,  7 Mar 2022 14:52:40 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id w127so6565760oig.10;
        Mon, 07 Mar 2022 14:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A2csD67qXGoEvqs1Prld6d2oP9SlviApXy9zPbagNDQ=;
        b=6YLk8fpAzvanY92PEGJjijjIQ5io9yEC7LQVBJEoD9lYrPKaU7eGFWncBDgmPiCWO7
         tuUioOVhrYGXhkQ5LBeyqJYMw/I22ARMzOOQs/WtGSMVhX98GpTWJJ14/UwKXdOx6PhO
         C8uqWYCXdFRyon8QvvdCKg0VTEln8qtaSk9dsd2XHNSezWXxDbAFZVeRIaUnDEzStUxB
         lZju5NA7btg4is2vfzck2eUPkqCPZ6led9priSd7lBX9gni2GlevzmkN6AnO7Tfkh0lB
         ci2KAo+sHiesdUjyJz7ZlNhPaYOl4AvPidelu4nYW9hsLk8+VBzkW65WohM3dL9m1A5e
         h1Mw==
X-Gm-Message-State: AOAM531YHfzQQFEBWC6OGcD6Sq+Nu4Ledz0lZHAV1ke65x3nu3106Yk3
        kS6Pv7yA/vDOgNafplQbVA==
X-Google-Smtp-Source: ABdhPJzwg6DunqXDMtn0yEvy0iRyMNFCMs9Y1knxfp1LMKwv8i7Tzf+hrKkDYPkVFGhsJAaNvBDOcQ==
X-Received: by 2002:a05:6808:f92:b0:2d9:d230:221c with SMTP id o18-20020a0568080f9200b002d9d230221cmr865229oiw.96.1646693560192;
        Mon, 07 Mar 2022 14:52:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bb39-20020a05680816a700b002d9a8eb89fasm3558038oib.46.2022.03.07.14.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:52:39 -0800 (PST)
Received: (nullmailer pid 3405258 invoked by uid 1000);
        Mon, 07 Mar 2022 22:52:38 -0000
Date:   Mon, 7 Mar 2022 16:52:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mwesigwa Guma <mguma@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org,
        Mattias Brugger <mbrugger@suse.com>,
        linux-input@vger.kernel.org, Joel Savitz <jsavitz@redhat.com>,
        fedora-rpi@googlegroups.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 4/6] dt-bindings: mfd: sensehat: Add Raspberry Pi
 Sense HAT schema
Message-ID: <YiaMtu901yHS+3Ql@robh.at.kernel.org>
References: <20220303173935.100622-1-cmirabil@redhat.com>
 <20220303173935.100622-5-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303173935.100622-5-cmirabil@redhat.com>
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

On Thu, 03 Mar 2022 12:39:33 -0500, Charles Mirabile wrote:
> This patch adds the device tree bindings for the Sense HAT
> and each of its children devices in yaml form.
> 
> Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> ---
>  .../raspberrypi,sensehat-display.yaml         | 27 ++++++++
>  .../input/raspberrypi,sensehat-joystick.yaml  | 33 +++++++++
>  .../bindings/mfd/raspberrypi,sensehat.yaml    | 69 +++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
>  create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
