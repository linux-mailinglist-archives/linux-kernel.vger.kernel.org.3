Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC72524DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354072AbiELNCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354055AbiELNCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:02:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435C362A1F;
        Thu, 12 May 2022 06:02:39 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KzX0W64fQz67nWs;
        Thu, 12 May 2022 20:59:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 15:02:36 +0200
Received: from localhost (10.81.210.133) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 14:02:35 +0100
Date:   Thu, 12 May 2022 14:02:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Jonathan Cameron <jic23@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add support for texas dac121c081 to the dac5571
 driver
Message-ID: <20220512140232.000078c1@Huawei.com>
In-Reply-To: <06546c40-639a-01e4-ed99-4895edfe8211@axentia.se>
References: <42db911c-5eba-0511-3e8c-8011a2a5b44a@axentia.se>
        <20220428204439.4ec2b4ae@jic23-huawei>
        <20220501190349.54aa48a3@jic23-huawei>
        <06546c40-639a-01e4-ed99-4895edfe8211@axentia.se>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.133]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 10:59:48 +0200
Peter Rosin <peda@axentia.se> wrote:

> HI!
> 
> 2022-05-01 at 20:03, Jonathan Cameron wrote:
> > On Thu, 28 Apr 2022 20:44:39 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> >> On Mon, 25 Apr 2022 22:46:30 +0200
> >> Peter Rosin <peda@axentia.se> wrote:
> >>  
> >>> Hi!
> >>>
> >>> The new chip works much like the other chips supported by the driver, so
> >>> this is just adding another compatible to the list.
> >>>
> >>> Chenages since v1:
> >>> - Guenter Roeck noticed elsewhere that my mail setup was botched and
> >>>   that my patches were clobbered. Hopefully fixed. *blush*
> >>> - added tags from Sean Nyekjaer and Rob Herring    
> >>
> >> Applied.  Thanks  
> > 
> > Backed out temporarily because they have crossed with a fix (that I'd
> > forgotten about) and were requiring a non trivial merge in linux-next.
> > 
> > https://patchwork.kernel.org/project/linux-iio/patch/20220324234340.32402-1-laurent.pinchart@ideasonboard.com/
> > 
> > Hopefully that will get resolved in my upstream fairly soon and I can
> > fix this one up whilst applying it myself.  
> 
> Looks like it might be time to bring this one in from the cold?

Nearly.  I have a pull request out to Greg. Once he's taken that
I'll fastforward the togreg branch to include the fix and
can then apply this.

Jonathan

> 
> Cheers,
> Peter

