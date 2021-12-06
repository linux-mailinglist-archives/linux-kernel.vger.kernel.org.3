Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8842746A3F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346847AbhLFS2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbhLFS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:28:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D1BC061746;
        Mon,  6 Dec 2021 10:25:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39629CE176D;
        Mon,  6 Dec 2021 18:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC7AC341C5;
        Mon,  6 Dec 2021 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638815116;
        bh=C+LpyN3FeznjnkrZjjleBRY72hCeq5EaNtgU0yH4WMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPg8KKuEXYfjgjQObgiJ5hCizRldL5h5LqkxFsdBYbKyu/M6tdBX47Dgm9S+2QtUp
         ZOaL4e4sR/8224FDWfgApfYhkONXQAdmtwObdCkvDArXsK6wiZdWrr9a6g0rlx5RxC
         kepcF3CQAyKOuZQlfvtu2GQFADSeUHsw9zNXQOog=
Date:   Mon, 6 Dec 2021 19:25:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: Add missing properties used in examples
Message-ID: <Ya5VhX8TA0LBn4Qd@kroah.com>
References: <20211206174113.2295616-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206174113.2295616-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:41:12AM -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the following warnings
> are generated in the usb examples:
> 
> Documentation/devicetree/bindings/usb/intel,keembay-dwc3.example.dt.yaml: usb: usb@34000000: Unevaluated properties are not allowed ('reg' was unexpected)
> Documentation/devicetree/bindings/usb/snps,dwc3.example.dt.yaml: usb@4a030000: Unevaluated properties are not allowed ('reg' was unexpected)
> 
> Add the missing property definitions.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/usb/intel,keembay-dwc3.yaml         | 3 +++
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml        | 6 ++++++
>  2 files changed, 9 insertions(+)

Do you want me to take these in my tree?  If not, you can take them in
yours:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Which ever is easier for you.

greg k-h
