Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67180479100
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbhLQQJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:09:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53094 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238858AbhLQQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:09:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16225622D4;
        Fri, 17 Dec 2021 16:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93CFC36AE1;
        Fri, 17 Dec 2021 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639757391;
        bh=3eD3FwRWdRoWkwbNbkkKNpTPoCY8N0kQPjbpzhChzHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYaQMlsl8aaSNDpBB9HYdTqJpgD9zCGkzr7z9hVliogKFgehb2lK2AeQcI47hqTfn
         laypUE+78ToHUQ1VGsEc9ex6ueDn7agjKuiDi9SPj3O1Bxtv+OnIHsewwC0cId+3tQ
         WU8sjcUq2u4xjfjmNzkMnAM46WSVim4yYo3lLrNM=
Date:   Fri, 17 Dec 2021 17:09:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 6/9] docs: sysfs: coresight: Add sysfs ABI
 documentation for TPDM
Message-ID: <Yby2TcAweYFDcc8P@kroah.com>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
 <20211209141543.21314-7-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209141543.21314-7-quic_jinlmao@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:15:40PM +0800, Mao Jinlong wrote:
> Add API usage document for sysfs API in TPDM driver.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-tpdm     | 12 ++++++++++++
>  MAINTAINERS                                          |  1 +
>  2 files changed, 13 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> new file mode 100644
> index 000000000000..fdd0bd0e1c33
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -0,0 +1,12 @@
> +What:		/sys/bus/coresight/devices/<tpdm-name>/available_datasets
> +Date:		December 2021
> +KernelVersion	5.16

5.16 already has all of the new features, so this will not make it into
that release.

thanks,

greg k-h
