Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505C15A6444
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiH3NAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiH3NAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:00:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FE467467;
        Tue, 30 Aug 2022 06:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C55C3B81AAC;
        Tue, 30 Aug 2022 13:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2146FC433D6;
        Tue, 30 Aug 2022 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661864442;
        bh=Rvc2bFCIFK22EQawxsOj2oGKNzfL8EY9xA5bD1tf4gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1IKvWl9ijPPNphkRJWR2GfaCDLJ6/fqGrBvh4I2NY0q6lfQOd3cU4m4XLyvCvNfd
         P2e+DQmFbCXpqUtMnVprgswcj5nVh6yxSFSor5piyuv7Oa2lTC5ChC/c5hehCz3vOF
         RfErQtZwi+CHAo3KqZa7rKbDg9s1IOaVKaiT20EI=
Date:   Tue, 30 Aug 2022 15:00:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v1 3/4] usb: typec: tcpci_maxim: Export helper function
 for register reads
Message-ID: <Yw4J9wv1N2Z5/qbN@kroah.com>
References: <20220826084001.3341215-1-badhri@google.com>
 <20220826084001.3341215-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826084001.3341215-3-badhri@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 01:40:00AM -0700, Badhri Jagan Sridharan wrote:
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

As Heikki pointed out, I can not accept changes with no changelog text
at all, you know this.

Please write a good changelog text that explains why you are doing this
so we can properly review it.  As it is, we have no idea what is going
on here at all.

thanks,

greg k-h
