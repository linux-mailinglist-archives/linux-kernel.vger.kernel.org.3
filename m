Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C963486542
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiAFNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:25:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43828 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiAFNZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:25:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1FE61C15
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8685EC36AE3;
        Thu,  6 Jan 2022 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641475535;
        bh=buV0gYWbk3HVWfvOrcfUs3J4fxNfedsrK8daEDtIzx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hD91Fm1JArQgrZOznJTSwWQEL/6hIlrqxutgzox5t1nFaTWlgdyHlSKHCIk29EqM7
         q0jq3/k1z/szOUrbA/H2GMjBYnnw9U2nKArcAeNP1QtN6yHgHcGAduWoZsob0X+1CW
         /ZGsqaX0JXae6lNEvno75wK3IZ5gebq9lSaltiYg=
Date:   Thu, 6 Jan 2022 14:25:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Gabriel Somlo <somlo@cmu.edu>,
        qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu_fw_cfg: use default_groups in kobj_type
Message-ID: <YdbtzL59aCePeDnt@kroah.com>
References: <20220105183133.2812848-1-gregkh@linuxfoundation.org>
 <20220105175546-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105175546-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 05:56:26PM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 05, 2022 at 07:31:33PM +0100, Greg Kroah-Hartman wrote:
> > There are currently 2 ways to create a set of sysfs files for a
> > kobj_type, through the default_attrs field, and the default_groups
> > field.  Move the firmware qemu_fw_cfg sysfs code to use default_groups
> > field which has been the preferred way since aa30f47cf666 ("kobject: Add
> > support for default attribute groups to kobj_type") so that we can soon
> > get rid of the obsolete default_attrs field.
> > 
> > Cc: Gabriel Somlo <somlo@cmu.edu>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> OK then you know best I guess
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> feel free to queue.

Thanks, will do!

greg k-h
