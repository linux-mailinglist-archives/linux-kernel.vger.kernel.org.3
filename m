Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D569D4C35C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiBXTY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiBXTY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:24:26 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF43239D75;
        Thu, 24 Feb 2022 11:23:56 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id j24so4359809oii.11;
        Thu, 24 Feb 2022 11:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ATEm+ezUxW7JC6KyJ4AzJTjSuX9kBPLT6sQlhoX0j0=;
        b=EnoCqH1BLAeqoJC9b7VoFNLMlGzPDP4PO0SzCs9x5aeTpCTKc/F5zLhoGTPIzztR1f
         NBAz1Gml4X7sgxyND2h2PDWdfjNh1AHgJ4yk442FmiMhpzaCH9spO3/ToC/Rx/qw/jR8
         ud2Buukn/xM1jwhhgjjqwpST9axEUXePMkvZ4CqzAKb84k6Xi15BIy1eSALWZQCJSunu
         BA3N4ClOBdXkX05wTtbHQkS3LyYSJ4whiMmlH8IhtESTWsv2G9+N64jC8gTGzYuk670i
         sw4rIq2VhzHEznxx1P31gkXTm4xvivTd0HTCSyAI85JQW+HhDDKHJYHl6N2WnEXPqucL
         jo7Q==
X-Gm-Message-State: AOAM530Y/H0rptDzJbl+v9lDe/5Ch+iB4XQtDlQwxqSKnKvDHVA3yULC
        3pDclgn4W4SZbE+gdhFqsA==
X-Google-Smtp-Source: ABdhPJxqMJgJOH+d1ye9jcXWq/7lxeQLktPMAnrmzC3IQGcpdrnrpbjSIvxa+udq3xfO6UIcWqw05w==
X-Received: by 2002:a05:6870:4301:b0:d4:1181:285f with SMTP id w1-20020a056870430100b000d41181285fmr6822568oah.93.1645730636188;
        Thu, 24 Feb 2022 11:23:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m21-20020a056820051500b0031d0841b87esm86236ooj.34.2022.02.24.11.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:23:55 -0800 (PST)
Received: (nullmailer pid 3439705 invoked by uid 1000);
        Thu, 24 Feb 2022 19:23:54 -0000
Date:   Thu, 24 Feb 2022 13:23:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     kernel@pengutronix.de, shawnguo@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        festevam@gmail.com, Peng Fan <peng.fan@nxp.com>,
        robh+dt@kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com, linux-imx@nxp.com, sboyd@kernel.org
Subject: Re: [PATCH V4 1/5] dt-bindings: clock: Add imx93 clock support
Message-ID: <YhfbShLhZ4qNOo0D@robh.at.kernel.org>
References: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
 <20220224082251.1397754-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224082251.1397754-2-peng.fan@oss.nxp.com>
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

On Thu, 24 Feb 2022 16:22:47 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add the clock dt-binding file for i.MX93.
> 
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/clock/imx93-clock.yaml           | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
