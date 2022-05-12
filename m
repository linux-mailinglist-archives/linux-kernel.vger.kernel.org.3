Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A30524640
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350610AbiELG6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350613AbiELG4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:56:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B751836F;
        Wed, 11 May 2022 23:56:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B75F51F91A;
        Thu, 12 May 2022 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652338601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ynfVyISLTocoM+sP5RWAS58Ty5c+joUC7e/SGWdE+18=;
        b=Syw6WsqdVcqFLDaZzsl+SWMrTmcGh2z6NY7TO/vV5kDe7WWbv4h6m5eRAjbZxXkFqyJpUP
        IhMfTLAvEruURlOP6Efk6CKIcuG4BpwSky4a2/uzHaw5VGw5XRTcMYYS9wajdkP6h685UQ
        t/6rN5C7GiNlV/EVf1ZMiEoSAhDXGbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652338601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ynfVyISLTocoM+sP5RWAS58Ty5c+joUC7e/SGWdE+18=;
        b=6kpqeVcGuGhqU/hg86ZGgh4ayDEm95Yjwg18QAMcWqXORog6QaFW56gKF4HdGhE+iJGnVs
        2b/auzxAfL5wNMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9412713A97;
        Thu, 12 May 2022 06:56:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hprbI6mvfGJSWQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:56:41 +0000
Message-ID: <5d7ae3e5-3f21-a610-7beb-274ede95850d@suse.de>
Date:   Thu, 12 May 2022 08:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 12/23] dt-bindings: ata: ahci: Add platform capability
 properties
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-13-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-13-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 01:17, Serge Semin wrote:
> In case if the platform doesn't have BIOS or a comprehensive firmware
> installed then the HBA capability flags will be left uninitialized. As a
> good alternative we can define a set AHCI DT-node properties to describe
> all of HW-init capabilities flags. Luckily there aren't too many of them.
> SSS - Staggered Spin-up support and MPS - Mechanical Presence Switch
> support determine the corresponding feature availability for whole HBA by
> means of the "hba-sss" and "hba-smps" properties.  Each port can have the
> "hba-{hpcp,mpsp,cpd,esp,fbscp}" defined indicatating that the port
> supports the next functionality: HPCP - HotPlug capable port, MPSP -
> Mechanical Presence Switch attached to a port, CPD - Cold Plug detection,
> ESP - External SATA Port (eSATA), FBSCP - FIS-based switching capable
> port.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Alternatively we could define them as a bitfield, but having a set of
> boolean properties seemed a better idea since in that case we can
> implement a simple inter-dependency rules for them, which can't be done
> should we take the bitfields path.
> ---
>   .../devicetree/bindings/ata/ahci-common.yaml  | 66 +++++++++++++++++++
>   .../bindings/ata/ahci-platform.yaml           | 11 ++++
>   2 files changed, 77 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
