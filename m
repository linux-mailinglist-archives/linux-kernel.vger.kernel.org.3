Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC6859EB18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiHWSeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiHWSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:33:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD29274DED;
        Tue, 23 Aug 2022 09:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85674B81E97;
        Tue, 23 Aug 2022 16:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09569C433C1;
        Tue, 23 Aug 2022 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661273749;
        bh=R70fG4B+eYYRHEDGUYsMmhuBL0FrSBnntlnkCeUNY4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVBCMwv9J4A19H+xbuLgzaFxQcQ3bOKAokZ58PkJU9uP9P/h0E38ucL8e4Y8suJKK
         XqL+P4lg8QeMcmKiGog+e2xVs6/CeGy/ANkG9KJ3onNoHcDdXNru1pm/0G/csOjvZo
         XL4BQCZx+uf7l51WgCUgoXJPLSEtaR1/8viyTUuFkZ/PvOb7VKCtmrebbSjthQuqi7
         SyerbiYBiEcdDJJQ/KFwtLdhCXyFvxIRhtmGNdNoCZm2a3xcN+Vpgtvlc8sIg2KkYw
         QxRjQh88b0861cB1VEa4TqAGZFoPoxGDkNbC7LJvAwOHXp+uSCY2Nn8lvYPcvdT8T6
         0KhgBVgtjzEFg==
Date:   Tue, 23 Aug 2022 11:55:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Replace one-element arrays with flexible-array
 members
Message-ID: <YwUGjgfu1S54ag04@work>
References: <cover.1660592640.git.gustavoars@kernel.org>
 <yq1k06z8vaw.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1k06z8vaw.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 11:59:22PM -0400, Martin K. Petersen wrote:
> 
> Gustavo,
> 
> > This series aims to replace one-element arrays with flexible-array
> > members in drivers/scsi/megaraid/
> 
> Applied to 6.1/scsi-staging, thanks!

Great. :)

Thanks, Martin.
--
Gustavo
