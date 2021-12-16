Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED412477A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhLPRbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhLPRbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:31:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D533C061574;
        Thu, 16 Dec 2021 09:31:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B596B82363;
        Thu, 16 Dec 2021 17:30:59 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id D28F8C36AE0;
        Thu, 16 Dec 2021 17:30:55 +0000 (UTC)
Date:   Thu, 16 Dec 2021 17:36:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings:iio:filter: add admv8818 doc
Message-ID: <20211216173619.6b71a72d@jic23-huawei>
In-Reply-To: <YbOCfcMS+tlSqgT5@robh.at.kernel.org>
References: <20211207155445.247444-1-antoniu.miclaus@analog.com>
        <20211207155445.247444-3-antoniu.miclaus@analog.com>
        <YbOCfcMS+tlSqgT5@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 10:38:21 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, 07 Dec 2021 17:54:44 +0200, Antoniu Miclaus wrote:
> > Add device tree bindings for the ADMV8818 Filter.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > changes in v3:
> >  - remove clock from `required` since it is optional.
> >  .../bindings/iio/filter/adi,admv8818.yaml     | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

There was a bonus blank line at the end of the file I tidied up whilst applying.

J
