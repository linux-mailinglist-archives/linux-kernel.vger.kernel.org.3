Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96324477B14
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbhLPRwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhLPRwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:52:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECDBC061574;
        Thu, 16 Dec 2021 09:52:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A914ECE2267;
        Thu, 16 Dec 2021 17:52:37 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 2D882C36AE5;
        Thu, 16 Dec 2021 17:52:32 +0000 (UTC)
Date:   Thu, 16 Dec 2021 17:57:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Message-ID: <20211216175757.1c1e94f2@jic23-huawei>
In-Reply-To: <20211213110825.244347-2-mihail.chindris@analog.com>
References: <20211213110825.244347-1-mihail.chindris@analog.com>
        <20211213110825.244347-2-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 11:08:24 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> Add documentation for ad3552r and ad3542r
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>

> +patternProperties:
> +  "^channel@([0-1])$":
> +    type: object
> +    description: Configurations of the DAC Channels
> +
> +    additionalProperties: false
> +    

spaces on line above. Fixed whilst applying.

> +    properties:
> +      reg:
> +        description: Channel number
> +        enum: [0, 1]
> +
	
