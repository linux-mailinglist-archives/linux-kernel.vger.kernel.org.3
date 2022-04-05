Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27E4F4804
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356682AbiDEVZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457413AbiDEQDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:12 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BA39BADA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:42:43 -0700 (PDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B8F943F825
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1649173361;
        bh=7GZo70Jkx4ortmGAZXr0kZLiNDeCCFGRN/cOmY89S9A=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=umvMb90loEvm5RM6Cw1CYa1JDq7Kky2Ei+/X+Kmxfy/eB0Ke/4Azx8kRD7d0F+KFG
         HdmqdPDhgFa471jZcLvI44CAGP9AEdo5Knwz0DcfLV/Z1ei7fAlqCSIKQ61PmBxQT4
         IV6jMsFv2GYcZ05kiMUE/8aVo0ubPeDlMNBITrUjFBcdi+9Gp3RFVQNfNRu7aDGn2o
         LmBrDYrPz3fwNh3n2CAhXFavwVxzks3gvPOCw3mvxWqexruyWuNXfq8qgBT6/OigB6
         66vtLDOu3x9cMrMeWXSIiV7SHkqSLvEzZu7aLeVPHSKK8/0/WE/ldcI7LDO9JY4kuL
         0aij2fGbxzWKQ==
Received: by mail-io1-f70.google.com with SMTP id e27-20020a056602045b00b00645bd576184so8642305iov.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7GZo70Jkx4ortmGAZXr0kZLiNDeCCFGRN/cOmY89S9A=;
        b=0zvL6xGQOdNVDWtB0LISkalkC0vdG10b3DkGcAHhdZFSoQWrIq8X0OW8aQdFEK7r6e
         ot1JudAhBCumR28Z2tqCDd2DOsbX0aOeK2V8j9jDr97iF9kjIGTdhS/CHJUtdXhUEh+g
         QHy1F42lktmY6UKY+SDazuAaNTFePBfrFRvSppnXcDK1PHOe4Opfz6KdCjeVOoy2Bhdt
         p2RU2KWspDHAUhy5LHqYgYbRJcSZ1BC+S4RLaA7DOnPrx1SDSAY+qBGf4e1fo3mqkYX4
         RqE/bwK9OyQ1ynfK+/jTkVEPHm2ii1ZMcaSGVrcAXoWi0DwUY9qtbiKJSGWQkAwJ//kK
         cRDA==
X-Gm-Message-State: AOAM533HW/CFjwd9ps9/N2DCFA+kP9hzv9xlrPkU3TmNZ48vH8ZFaJLf
        +U9IDoVFsvQcirgAGbnujTbVZ28fa5rCYo4zw/VYzcDyxBEGLY23SECtLZSpzPGXotZHBEQ8V7n
        +p2bcLcvotE741XFCXWfskkf00lZktM+6OehJM2QC1A==
X-Received: by 2002:a02:cb4a:0:b0:323:5e9a:255c with SMTP id k10-20020a02cb4a000000b003235e9a255cmr2250782jap.12.1649173360736;
        Tue, 05 Apr 2022 08:42:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG1CiHUIYRegMsFTGUVXr2Te/jPu6rIoOR95h9XYPxdlcZ8BM13OWSDEv0JghT9pe8e2TG/A==
X-Received: by 2002:a02:cb4a:0:b0:323:5e9a:255c with SMTP id k10-20020a02cb4a000000b003235e9a255cmr2250763jap.12.1649173360498;
        Tue, 05 Apr 2022 08:42:40 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
        by smtp.gmail.com with ESMTPSA id i12-20020a92c94c000000b002ca56c2cf67sm1508389ilq.28.2022.04.05.08.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:42:39 -0700 (PDT)
Date:   Tue, 5 Apr 2022 09:42:37 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>
Subject: Re: [PATCH 5.16 0199/1017] PCI: xgene: Revert "PCI: xgene: Fix IB
 window setup"
Message-ID: <YkxjbVp3W2LeVIeL@xps13.dannf>
References: <20220405070354.155796697@linuxfoundation.org>
 <20220405070400.156176848@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405070400.156176848@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:18:32AM +0200, Greg Kroah-Hartman wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> commit 825da4e9cec68713fbb02dc6f71fe1bf65fe8050 upstream.
> 
> Commit c7a75d07827a ("PCI: xgene: Fix IB window setup") tried to
> fix the damages that 6dce5aa59e0b ("PCI: xgene: Use inbound resources
> for setup") caused, but actually didn't improve anything for some
> plarforms (at least Mustang and m400 are still broken).
> 
> Given that 6dce5aa59e0b has been reverted, revert this patch as well,
> restoring the PCIe support on XGene to its pre-5.5, working state.
> 
> Link: https://lore.kernel.org/r/YjN8pT5e6/8cRohQ@xps13.dannf
> Link: https://lore.kernel.org/r/20220321104843.949645-3-maz@kernel.org
> Fixes: c7a75d07827a ("PCI: xgene: Fix IB window setup")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: stable@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: Toan Le <toan@os.amperecomputing.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Krzysztof Wilczyński <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stéphane Graber <stgraber@ubuntu.com>
> Cc: dann frazier <dann.frazier@canonical.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pci/controller/pci-xgene.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Greg,

  I don't think it makes sense to apply this to 5.10.y, 5.15.y &
5.16.y w/o also applying a backport of 1874b6d7ab1, because without
that we will regress support for Stéphane's X-Gene2-based systems. The
backport of 1874b6d7ab1 was rejected for these trees because it doesn't
apply cleanly, but I've just submitted new versions that do.

  -dann
