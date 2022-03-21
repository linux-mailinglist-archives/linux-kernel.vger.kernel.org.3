Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9814E23ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbiCUKE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbiCUKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:04:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEB93C723;
        Mon, 21 Mar 2022 03:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DEDC612D7;
        Mon, 21 Mar 2022 10:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3718AC340E8;
        Mon, 21 Mar 2022 10:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647857008;
        bh=Urs1WBqJhnohfH0zLlL03sA1jfDJexJVbVcUFckiFGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M71m8WKC9uJ11+TpouqdAedjog3Y7ReATMY41tjTuDB6z6q+HWjN9rCaw0ZbVyLfj
         afj9hNC9ylnp5ueaxuAlzGFESs8TO4EufIfxhwK9dpdkBz6fCLIXRt+MSguwqcTpqN
         VYOos0MNu241dfTkSQTpcyX2Petp34pVp+Gl227g=
Date:   Mon, 21 Mar 2022 11:03:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v7 9/9] docs: ABI: testing: Document the Ampere Altra
 Family's SMpro sysfs interfaces
Message-ID: <YjhNbUDFUXsNkL+/@kroah.com>
References: <20220321081355.6802-1-quan@os.amperecomputing.com>
 <20220321081355.6802-10-quan@os.amperecomputing.com>
 <Yjg2AkYOCTi2CXc1@kroah.com>
 <8f01a63d-0d10-81ee-7398-b69e496964f8@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f01a63d-0d10-81ee-7398-b69e496964f8@os.amperecomputing.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:46:36PM +0700, Quan Nguyen wrote:
> 
> 
> On 21/03/2022 15:23, Greg Kroah-Hartman wrote:
> > On Mon, Mar 21, 2022 at 03:13:55PM +0700, Quan Nguyen wrote:
> > > Add documentation for the Ampere(R)'s Altra(R) SMpro sysfs interfaces
> > > 
> > > Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> > > ---
> > > Changes in v7:
> > >    + First introduce in v7     [Greg]
> > > 
> > >   .../sysfs-bus-platform-devices-ampere-smpro   | 133 ++++++++++++++++++
> > >   1 file changed, 133 insertions(+)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
> > > new file mode 100644
> > > index 000000000000..9bfd8d6d0f71
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
> > > @@ -0,0 +1,133 @@
> > > +What:		/sys/bus/platform/devices/smpro-errmon.*/errors_[core|mem|pcie|other]_[ce|ue]
> > 
> > Please split this out as one entry per file.
> > 
> 
> These sysfs share same format of HW errors (the 48-byte Arm vendor specific
> HW error record) but for separate HW domains: Core, PCIe, Mem... etc
> 
> > > +KernelVersion:	5.14
> > 
> > 5.14 is a long time ago.
> > 
> > > +Contact:	quan@os.amperecomputing.com
> > > +Description:
> > > +		(RO) Contains the 48-byte Ampere (Vendor-Specific) Error Record, see [1]
> > > +		printed in hex format as below:
> > > +
> > > +		AA BB CCCC DDDDDDDD DDDDDDDDDDDDDDDD DDDDDDDDDDDDDDDD \
> > > +		   DDDDDDDDDDDDDDDD DDDDDDDDDDDDDDDD DDDDDDDDDDDDDDDD
> > > +		Where:
> > > +		  AA       : Error Type
> > > +		  BB       : Subtype
> > > +		  CCCC     : Instance
> > > +		  DDD...DDD: Similar to the Arm RAS standard error record
> > 
> > No, this is not a valid sysfs file, sorry.  This should just be one
> > value per file.
> > 
> 
> This 48-byte value is unable to separate into smaller values because it
> contain all information necessary to indicate a single HW error as per ARM
> RAS supplement document [1]. The format is to make it read-able other than a
> single 48-byte hex value.
> 
> [1] https://developer.arm.com/documentation/ddi0587/latest/

Just export the 48 byte hex value and make userspace split it up if it
wants to do so.  Don't do things in the kernel that can be done in
userspace.

thanks,

greg k-h
