Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705A758F8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiHKIXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiHKIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:23:32 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECAB6B161;
        Thu, 11 Aug 2022 01:23:30 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aea52.dynamic.kabel-deutschland.de [95.90.234.82])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 01C1361EA192C;
        Thu, 11 Aug 2022 10:23:26 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------N1wXLFsF1u2GW66ii3eT0OJh"
Message-ID: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
Date:   Thu, 11 Aug 2022 10:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------N1wXLFsF1u2GW66ii3eT0OJh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: folks from IPU6 external driver, IPU3 maintainers, Dell, Lenovo, 
Chromium, Canonical/Ubuntu, Red Hat]

Dear Greg,


I am writing you, because I remember you – at least – were active 
several years ago in getting good upstream driver support into the Linux 
kernel.

It looks like the driver for the MIPI IPU6 camera of Intel Alder Lake 
based laptops, for example, Lenovo ThinkPad X1 Carbon and Dell XPS 13 
9315/9320, is not in the upstream Linux kernel.

With Ubuntu’s OEM image pre-installed by Dell, and on Google Chromebooks 
the camera is supposedly working [1]. There is a GitHub project with a 
repository for the Linux kernel patches [2], but the patches – as 
expected, and known from other external drivers, and Android drivers – 
do not build against all Linux kernel versions [3]. A request to 
upstream the drivers was opened at the end of March [4], and got the 
reply below in July:

> Intel is not ready yet to provide technical support to various Linux
> distro and all OEM devices at this moment with Intel IPU6 github.
> 
> Intel is supporting Dell laptop and their MIPI camera functionality
> on Ubuntu with release/integration support from Canonical. If you are
> using Dell devices, please refer to the devices listed in this link.
> (https://wiki.ubuntu.com/Dell) You can learn the latest updates from
> the installation guide.
The patches were integrated into ChromiumOS’ Linux kernel tree – for 
specific version, like 5.15 [5], and the same for Ubuntu 22.04 with 
Linux 5.15 – only in June [6]. A lot of that (redundant) work seems to 
be done by the Intel developers involved also in the GitHub project.

In the last seven or so years Linux upstream driver support worked well 
for me – especially with Intel hardware –, so I wanted to make you (and 
others) aware of the situation, and hope, that you could do something 
about the situation. With the current situation I can only recommend to 
FLOSS users to *not* buy these devices.


Kind regards,

Paul


PS: The proprietary firmware is also not in the linux-firmware 
repository [7], and the user space packages [8] are also not packaged 
yet for some distributions like Debian.

PPS: VA-API support also does not work [9].

[1]: https://ubuntu.com/certified/202203-30070
[2]: https://github.com/intel/ipu6-drivers
[3]: https://github.com/intel/ipu6-drivers/issues/13
[4]: https://github.com/intel/ipu6-drivers/issues/22
[5]: 
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3034663
[6]: 
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/log/drivers/media/pci/intel
[7]: https://bugs.launchpad.net/ubuntu/+source/linux-firmware/+bug/1955383
[8]: 
https://launchpad.net/~oem-solutions-group/+archive/ubuntu/intel-ipu6/+packages
[9]: https://github.com/intel/media-driver/issues/1371
--------------N1wXLFsF1u2GW66ii3eT0OJh
Content-Type: text/plain; charset=UTF-8; name="lspci-nn.txt"
Content-Disposition: attachment; filename="lspci-nn.txt"
Content-Transfer-Encoding: base64

JCBsc3BjaSAtbm4KMDA6MDAuMCBIb3N0IGJyaWRnZSBbMDYwMF06IEludGVsIENvcnBvcmF0
aW9uIERldmljZSBbODA4Njo0NjAyXSAocmV2IDA2KQowMDowMi4wIFZHQSBjb21wYXRpYmxl
IGNvbnRyb2xsZXIgWzAzMDBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBBbGRlciBMYWtlLVVQNCBH
VDIgW0lyaXMgWGUgR3JhcGhpY3NdIFs4MDg2OjQ2YWFdIChyZXYgMGMpCjAwOjA0LjAgU2ln
bmFsIHByb2Nlc3NpbmcgY29udHJvbGxlciBbMTE4MF06IEludGVsIENvcnBvcmF0aW9uIEFs
ZGVyIExha2UgSW5ub3ZhdGlvbiBQbGF0Zm9ybSBGcmFtZXdvcmsgUHJvY2Vzc29yIFBhcnRp
Y2lwYW50IFs4MDg2OjQ2MWRdIChyZXYgMDYpCjAwOjA1LjAgTXVsdGltZWRpYSBjb250cm9s
bGVyIFswNDgwXTogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIFs4MDg2OjQ2NWRdIChyZXYg
MDYpCjAwOjA2LjAgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0aW9uIDEydGgg
R2VuIENvcmUgUHJvY2Vzc29yIFBDSSBFeHByZXNzIHg0IENvbnRyb2xsZXIgIzAgWzgwODY6
NDY0ZF0gKHJldiAwNikKMDA6MDcuMCBQQ0kgYnJpZGdlIFswNjA0XTogSW50ZWwgQ29ycG9y
YXRpb24gQWxkZXIgTGFrZS1QIFRodW5kZXJib2x0IDQgUENJIEV4cHJlc3MgUm9vdCBQb3J0
ICMwIFs4MDg2OjQ2NmVdIChyZXYgMDYpCjAwOjA3LjEgUENJIGJyaWRnZSBbMDYwNF06IElu
dGVsIENvcnBvcmF0aW9uIEFsZGVyIExha2UtUCBUaHVuZGVyYm9sdCA0IFBDSSBFeHByZXNz
IFJvb3QgUG9ydCAjMSBbODA4Njo0NjNmXSAocmV2IDA2KQowMDowOC4wIFN5c3RlbSBwZXJp
cGhlcmFsIFswODgwXTogSW50ZWwgQ29ycG9yYXRpb24gMTJ0aCBHZW4gQ29yZSBQcm9jZXNz
b3IgR2F1c3NpYW4gJiBOZXVyYWwgQWNjZWxlcmF0b3IgWzgwODY6NDY0Zl0gKHJldiAwNikK
MDA6MGQuMCBVU0IgY29udHJvbGxlciBbMGMwM106IEludGVsIENvcnBvcmF0aW9uIEFsZGVy
IExha2UtUCBUaHVuZGVyYm9sdCA0IFVTQiBDb250cm9sbGVyIFs4MDg2OjQ2MWVdIChyZXYg
MDYpCjAwOjBkLjIgVVNCIGNvbnRyb2xsZXIgWzBjMDNdOiBJbnRlbCBDb3Jwb3JhdGlvbiBB
bGRlciBMYWtlLVAgVGh1bmRlcmJvbHQgNCBOSEkgIzAgWzgwODY6NDYzZV0gKHJldiAwNikK
MDA6MTIuMCBTZXJpYWwgY29udHJvbGxlciBbMDcwMF06IEludGVsIENvcnBvcmF0aW9uIERl
dmljZSBbODA4Njo1MWZjXSAocmV2IDAxKQowMDoxNC4wIFVTQiBjb250cm9sbGVyIFswYzAz
XTogSW50ZWwgQ29ycG9yYXRpb24gQWxkZXIgTGFrZSBQQ0ggVVNCIDMuMiB4SENJIEhvc3Qg
Q29udHJvbGxlciBbODA4Njo1MWVkXSAocmV2IDAxKQowMDoxNC4yIFJBTSBtZW1vcnkgWzA1
MDBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBBbGRlciBMYWtlIFBDSCBTaGFyZWQgU1JBTSBbODA4
Njo1MWVmXSAocmV2IDAxKQowMDoxNC4zIE5ldHdvcmsgY29udHJvbGxlciBbMDI4MF06IElu
dGVsIENvcnBvcmF0aW9uIEFsZGVyIExha2UtUCBQQ0ggQ05WaSBXaUZpIFs4MDg2OjUxZjBd
IChyZXYgMDEpCjAwOjE1LjAgU2VyaWFsIGJ1cyBjb250cm9sbGVyIFswYzgwXTogSW50ZWwg
Q29ycG9yYXRpb24gQWxkZXIgTGFrZSBQQ0ggU2VyaWFsIElPIEkyQyBDb250cm9sbGVyICMw
IFs4MDg2OjUxZThdIChyZXYgMDEpCjAwOjE1LjEgU2VyaWFsIGJ1cyBjb250cm9sbGVyIFsw
YzgwXTogSW50ZWwgQ29ycG9yYXRpb24gQWxkZXIgTGFrZSBQQ0ggU2VyaWFsIElPIEkyQyBD
b250cm9sbGVyICMxIFs4MDg2OjUxZTldIChyZXYgMDEpCjAwOjE2LjAgQ29tbXVuaWNhdGlv
biBjb250cm9sbGVyIFswNzgwXTogSW50ZWwgQ29ycG9yYXRpb24gQWxkZXIgTGFrZSBQQ0gg
SEVDSSBDb250cm9sbGVyIFs4MDg2OjUxZTBdIChyZXYgMDEpCjAwOjFlLjAgQ29tbXVuaWNh
dGlvbiBjb250cm9sbGVyIFswNzgwXTogSW50ZWwgQ29ycG9yYXRpb24gQWxkZXIgTGFrZSBQ
Q0ggVUFSVCAjMCBbODA4Njo1MWE4XSAocmV2IDAxKQowMDoxZS4yIFNlcmlhbCBidXMgY29u
dHJvbGxlciBbMGM4MF06IEludGVsIENvcnBvcmF0aW9uIERldmljZSBbODA4Njo1MWFhXSAo
cmV2IDAxKQowMDoxZS4zIFNlcmlhbCBidXMgY29udHJvbGxlciBbMGM4MF06IEludGVsIENv
cnBvcmF0aW9uIERldmljZSBbODA4Njo1MWFiXSAocmV2IDAxKQowMDoxZi4wIElTQSBicmlk
Z2UgWzA2MDFdOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgWzgwODY6NTE4N10gKHJldiAw
MSkKMDA6MWYuMyBNdWx0aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXIgWzA0MDFdOiBJbnRlbCBD
b3Jwb3JhdGlvbiBEZXZpY2UgWzgwODY6NTFjY10gKHJldiAwMSkKMDA6MWYuNCBTTUJ1cyBb
MGMwNV06IEludGVsIENvcnBvcmF0aW9uIEFsZGVyIExha2UgUENILVAgU01CdXMgSG9zdCBD
b250cm9sbGVyIFs4MDg2OjUxYTNdIChyZXYgMDEpCjAwOjFmLjUgU2VyaWFsIGJ1cyBjb250
cm9sbGVyIFswYzgwXTogSW50ZWwgQ29ycG9yYXRpb24gQWxkZXIgTGFrZS1QIFBDSCBTUEkg
Q29udHJvbGxlciBbODA4Njo1MWE0XSAocmV2IDAxKQowMTowMC4wIE5vbi1Wb2xhdGlsZSBt
ZW1vcnkgY29udHJvbGxlciBbMDEwOF06IFBoaXNvbiBFbGVjdHJvbmljcyBDb3Jwb3JhdGlv
biBEZXZpY2UgWzE5ODc6NTAxOV0gKHJldiAwMSkK

--------------N1wXLFsF1u2GW66ii3eT0OJh--
