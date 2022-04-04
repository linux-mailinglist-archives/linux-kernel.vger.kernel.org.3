Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EFF4F1444
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbiDDMEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiDDMES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:04:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78943527B;
        Mon,  4 Apr 2022 05:02:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88DE1B81608;
        Mon,  4 Apr 2022 12:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CFCC340EE;
        Mon,  4 Apr 2022 12:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649073740;
        bh=D/Vuu1Efh10DrjnfMeFaJx5tjWBKjQcsLECUsZvdKqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFDhCUePm0ddXfoqny4l8DyDXi4vHw5bzwZ1ifeeo/2XY8mUGypdbbcu5F8zLy798
         6x0TBU2vIESELoL5esXnXn7H/ZUOPtPtqu7k1/ccKhKEQgB4islWjUp5Afb69vgooB
         LrZBVEusFqXoO92vlrVRIz+QslnbRt0d6PsuhPN0=
Date:   Mon, 4 Apr 2022 14:02:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
        linux-iio@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>, Chao Yu <chao@kernel.org>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: unexpected indentation warning in
 Documentation/ABI/testing/sysfs-*
Message-ID: <YkreSbV4+KmW1/zV@kroah.com>
References: <564f87a9-dd57-d3a1-d476-d81350baf75d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564f87a9-dd57-d3a1-d476-d81350baf75d@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 06:58:16PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> Doing "make htmldocs" for Linux v5.18-rc1, I get new warnings:
> 
> <path/to/linux>/Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Block quote ends without a blank line; unexpected unindent.
> <path/to/linux>/Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Definition list ends without a blank line; unexpected unindent.
> <path/to/linux>/Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-fs-erofs:10: WARNING: Unexpected indentation.
> <path/to/linux>/Documentation/ABI/testing/sysfs-fs-erofs:10: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Introduced by 2546c60004309e (platform/x86: Add Intel Software Defined
> Silicon driver, 2022-02-11), 2bec6d9aa89cbe (docs: ABI: sysfs-bus-nvdimm:
> Document sysfs event format entries for nvdimm pmu, 2022-02-25),
> e8a60aa7404bfe (platform/x86: Introduce support for Systems Management
> Driver over WMI for Dell Systems), 40452ffca3c1a0 (erofs: add sysfs
> node to control sync decompression strategy, 2021-12-06), and
> 4c18a890dff8d9 (iio:proximity:sx9324: Add SX9324 support, 2022-01-01).
> 
> Presumably because Sphinx mistakes these documentation files without
> extensions for .rst files? I dunno.
> 
> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>

Care to send patches to fix these up?

thanks,

greg k-h
