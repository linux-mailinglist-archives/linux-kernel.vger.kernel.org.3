Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37A492433
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiARLBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:01:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37776 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiARLBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:01:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B4D2612C6;
        Tue, 18 Jan 2022 11:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21D2C00446;
        Tue, 18 Jan 2022 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642503664;
        bh=bR6Zjg1Rsoqe4xWLfMAOJ4LfxnIbMO5RLSncYA0sU18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vobSL6dYkoyCr+D2L2GS1X8zpncLBcAGlkWAVSL6e++m2GjH4M4CeqJotOW/0S2uP
         M0d0ir9EdHSCbQaHXAcVUqIgA7wP/wNwA/MfCxDBuePvBcATRMa0/UtxEGkZ+Efo+Y
         XQeBqsn5JZnTo5v9DhQWJCxMRqL5gZZGasYcN3YY=
Date:   Tue, 18 Jan 2022 12:01:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Cc:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 1/1] usb: dwc2: gadget: don't try to disable ep0 in
 dwc2_hsotg_suspend
Message-ID: <Yead7Sjo85S8+hHq@kroah.com>
References: <20211207130101.270314-1-amelie.delaunay@foss.st.com>
 <39694435-d44b-64f8-9614-6082f9c22443@synopsys.com>
 <1f8db483-0965-e87d-20b0-4f2bccd9a3dd@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8db483-0965-e87d-20b0-4f2bccd9a3dd@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 11:40:46AM +0100, Amelie DELAUNAY wrote:
> Hi Greg,
> 
> Kind reminder about this patch.

It is the middle of the merge window, I can not add any patches to my
tree until 5.17-rc1 is out.

thanks,

greg k-h
