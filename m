Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7486D4AD3E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349572AbiBHIsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbiBHIsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:48:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACA5C0401F6;
        Tue,  8 Feb 2022 00:48:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC63612E7;
        Tue,  8 Feb 2022 08:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F517C004E1;
        Tue,  8 Feb 2022 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644310099;
        bh=3j9HRDTAPooNomNJ2KW8BWZrOcpm7xsRbvXnHzcbzOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zJ0fqhgb8CfNUU8fhNOqvWzN+c21yi4xxs1fUU9Lqq+Uufp8PZms0Mpo2Vze4p+j4
         4dp2buhFbpbPhfnIs5/lg3BtqsrHP+i0VtDEixmf1tV084TmDdYc/213nTWmG9KUlL
         C6dwEPHoNdhsElwiW37dc9l1osa7b3m46woNWWnc=
Date:   Tue, 8 Feb 2022 09:48:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <YgIuUIQ8EJqzNw6s@kroah.com>
References: <20220208084240.3678980-1-xji@analogixsemi.com>
 <20220208084240.3678980-2-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208084240.3678980-2-xji@analogixsemi.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 04:42:39PM +0800, Xin Ji wrote:
> +#define DEBUG

Please no.  Rely on dynamic debugging options, not hard-coded ones like
this.

Please remove this.

thanks,

greg k-h
