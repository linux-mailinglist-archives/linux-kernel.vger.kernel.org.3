Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2AA470CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbhLJWLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:11:39 -0500
Received: from mail-oo1-f46.google.com ([209.85.161.46]:38644 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhLJWLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:11:38 -0500
Received: by mail-oo1-f46.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so2724735ooj.5;
        Fri, 10 Dec 2021 14:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dSdG9nJFJuyBkjPl7i3Xp4GNypO3ixYbkFYerUG4P5U=;
        b=Ovhznx7wficMEToMfgI1TxhSqVsA4AUXx7KkVImxeduLmY6Srjo0B32c50hbs+nKGD
         5wIkk6eXDNjPZm3yTS+KPfmGrqcR+StXRXUCBGlYLhU/CmY8IM2kkKLqHB7s9PYmgxUo
         zQJlap6vPi+EZeTtWo9qSDJj/oDG27zRKT6d4I/Po+23JAeb8V9suIgnzqmAbmNuBaIu
         /pMQlmT7xAuSwumZdQBEQ9BIVC4cSjF76L07R5Fys9D8CGrwOWT7TaiKY74M9Rn3peJV
         KCIzi7ZaW3wPSW0pD1WdLUIMk9E95bcCHDizM25ipcyPLlrygIbGruyvxk/7eMpcRzWy
         AKZQ==
X-Gm-Message-State: AOAM533g0u8zKDdQkz/JH1TxWcXY7mS6x7x3LjIv6tUgkDtmZOzh6wkI
        w0ZrDq7/dIseE3qQ0vK02w==
X-Google-Smtp-Source: ABdhPJyJCf+9Z6vDYJg2pcSlFHdZFfsltzkCG3GvR7XTf5VffJPqHoOBZpwuB2Z+lA2DQeNAfDfJSA==
X-Received: by 2002:a4a:d184:: with SMTP id j4mr9863530oor.72.1639174082805;
        Fri, 10 Dec 2021 14:08:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k12sm728702ots.77.2021.12.10.14.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:08:01 -0800 (PST)
Received: (nullmailer pid 2013785 invoked by uid 1000);
        Fri, 10 Dec 2021 22:08:01 -0000
Date:   Fri, 10 Dec 2021 16:08:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lh.kuo@sunplus.com,
        linux-spi@vger.kernel.org, andyshevchenko@gmail.com,
        broonie@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, wells.lu@sunplus.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v4 2/2] devicetree: bindings SPI Add bindings doc for
 Sunplus SP7021
Message-ID: <YbPPwaqBQ5TCW/JE@robh.at.kernel.org>
References: <cover.1639123362.git.lhjeff911@gmail.com>
 <09f5be1f5c87a05e155dd09e76f074ce38840588.1639123362.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f5be1f5c87a05e155dd09e76f074ce38840588.1639123362.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 17:02:48 +0800, Li-hao Kuo wrote:
> From: "Li-hao Kuo" <lhjeff911@gmail.com>
> 
> Add devicetree bindings SPI Add bindings doc for Sunplus SP7021
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v4:
>  - Addressed all comments from Mr. Philipp Zabel
>  - Addressed all comments from Mr. Rob Herring
>  - Addressed all comments from Mr. Andy Shevchenko
> 
>  .../bindings/spi/spi-sunplus-sp7021.yaml           | 81 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
